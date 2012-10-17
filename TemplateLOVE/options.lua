-- Options screen
-- (c) Adrian Gordon 2012
-- Simple template/placeholder options screen

options = {}

function options.init() -- Initialise default graphics settings

	--Load the background image
	options.bg = love.graphics.newImage( "ui_assets/options/options_bg.png" )
	
	--supported values
	sup_modes			= love.graphics.getModes()
	
	--sort from low to high
	table.sort(sup_modes, function(a, b) return a.width*a.height < b.width*b.height end)
	
	--minimum width/height
	options.minWidth 	= 800
	options.minHeight 	= 600
	
	--remove any modes under the minimum
	for i=#sup_modes, 1, -1 do
		if sup_modes[i].width < options.minWidth or sup_modes[i].height < options.minHeight then
			table.remove( sup_modes, i )
		end
	end
	
	maxFSAA				= 8
	
	option_items		= { "Windowed", "Fullscreen", "Vsync", "Fullscreen", "FSAA",
							"Apply changes", "Cancel" }
	cur_option			= 1
	
	--current options
	options.cur_w_mode		= 1
	options.cur_fs_mode		= 1
	options.cur_w_res		= 1
	options.cur_fs_res		= 1
	options.cur_vsync		= true
	options.cur_fullscreen	= false
	options.cur_fsaa		= 0
	
	-- Update with real settings
	options.fetchsettings()
	
	--Menu position
	options.titlePosX	= 0.05
	options.titlePosY	= 0.075
	options.menuPosX	= 0.28
	options.menuPosY	= 0.26
	options.onresolutionchange()
	
	--mouseover
	options.mouseover	= false
	
	--option spacing
	reset_color			= false
	option_spacing		= 46
	option_xOffset		= 400
	optionMenuX			= 0.1
	optionMenuY			= 0.225
end

-- Update
function options.update(dt)

	if c.use_keyboard then
		--adjust current selection
		if cur_option > #option_items then
			cur_option = 1
		elseif cur_option < 1 then
			cur_option = #option_items
		end
	end
	
	-- Check mouse position
	if not c.use_mouse then
		return nil
	end
	local mx, my = love.mouse.getPosition()
	
	-- If the mouse hasn't moved, bail
	if mx == previous_mouse_x and my == previous_mouse_y then
		return nil
	end
	
	-- Reset mouseover 
	options.mouseover = false
	
	--love.graphics.getWidth()*options.menuPosX, (love.graphics.getHeight()*options.menuPosY) + option_spacing * 1
	for i=1, #option_items+1, 1 do
		if i==6 then i = 7 end--6 is skipped, there's nothing there
		
		if menu.checkbutton_mouseover(mx, my,
									  love.graphics.getWidth()*options.menuPosX,
									  (love.graphics.getHeight()*options.menuPosY) + (option_spacing * i ),
									  love.graphics.getWidth(),
									  option_spacing ) then
									  
			local newOption = i
			if i > 6 then newOption = newOption - 1 end
			cur_option = newOption	
			options.mouseover = true
		end
		
	end
end

-- Draw
function options.draw()

	--Draw the background at current resolution
	--love.graphics.draw( options.bg, 0, 0, math.rad(0), love.graphics.getWidth()/title_bg:getWidth(), love.graphics.getHeight()/title_bg:getHeight(), 0, 0 )
	if c.menu_scalebg then
		draw_scalemode( options.bg, c.menu_scalemode )
	else
		love.graphics.draw( options.bg, 0, 0, math.rad(0), love.graphics.getWidth()/title_bg:getWidth(), love.graphics.getHeight()/title_bg:getHeight(), 0, 0 )
	end
	--temp
	love.graphics.setFont( fonts.pBig )
	love.graphics.setColor( title_color )
	love.graphics.print( "Options Menu", love.graphics.getWidth()*options.titlePosX, love.graphics.getHeight()*options.titlePosY )
	
	--Draw menu options
	love.graphics.setFont( fonts.pSmall )
	love.graphics.setColor( menuItem_color )
	
	-- wRes
	options.draw_wres()
	--fsRes
	options.draw_fsres()
	--vsync
	options.draw_vsync()
	--fullscreen
	options.draw_fs()
	--fsaa
	options.draw_fsaa()
	--apply changes
	options.draw_apply()
	--cancel
	options.draw_cancel()
end

function options.keypressed(key)

	if not c.use_keyboard then
		return nil
	end

	--Menu navigation
	if key == 'escape' then -- Exit back out to the menu
		options.close_menu()
	end
	
	-- Settings navigation
	if key == "up" then
		cur_option = cur_option - 1
	elseif key == "down" then
		cur_option = cur_option + 1
	end
	
	--Settings changes
	if key == "left" then
		options.processinput("left")
	elseif key == "right" then
		options.processinput("right")
	end
	
	--Check whether to apply settings
	if (key == ' ' or key == "return") and cur_option == 6 then
		options.applysettings()
	end
	--or exit the options menu
	if (key == ' ' or key == "return") and cur_option == 7 then
		options.close_menu()
	end
	
end

-- Process Mouse events
function options.mousepressed( x,y,k )
	if options.mouseover and k == "l" then
		options.processinput( "right" )
	end
	
	-- Check whether to apply settings
	if options.mouseover and k == "l" and cur_option == 6 then
		options.applysettings()
	end
	
	-- Check for cancel
	if options.mouseover and k == "l" and cur_option == 7 then
		options.close_menu()
	end
end

-- Determine the selected option input response
function options.processinput( dir )

	if cur_option 		== 1 then 		--WINDOWED_RES
		
		if dir == "left" then
			options.cur_w_mode = options.cur_w_mode - 1
		elseif dir == "right" then
			options.cur_w_mode = options.cur_w_mode + 1
		end
		
		if options.cur_w_mode > #sup_modes then
			options.cur_w_mode = 1
		elseif options.cur_w_mode < 1 then
			options.cur_w_mode = #sup_modes
		end
		
	elseif cur_option 	== 2 then 	--FULLSCREEN_RES
	
		if dir == "left" then
			options.cur_fs_mode = options.cur_fs_mode - 1
		elseif dir == "right" then
			options.cur_fs_mode = options.cur_fs_mode + 1
		end
		
		if options.cur_fs_mode > #sup_modes then
			options.cur_fs_mode = 1
		elseif options.cur_fs_mode < 1 then
			options.cur_fs_mode = #sup_modes
		end
	
	elseif cur_option	== 3 then 	--VSYNC
	
		if options.cur_vsync == true then
			options.cur_vsync = false
		else
			options.cur_vsync = true
		end
	
	elseif cur_option	== 4 then 	--FULLSCREEN
	
		if options.cur_fullscreen == true then
			options.cur_fullscreen = false
		else
			options.cur_fullscreen = true
		end
	
	elseif cur_option	== 5 then 	--FSAA
	
		if dir == "left" then
			options.cur_fsaa = options.cur_fsaa - 1
		elseif dir == "right" then
			options.cur_fsaa = options.cur_fsaa + 1
		end
		
		if options.cur_fsaa > maxFSAA then
			options.cur_fsaa = 0
		elseif options.cur_fsaa < 0 then
			options.cur_fsaa = maxFSAA
		end
	
	end
end

-- Apply settings to game window
function options.applysettings()
	
	local w, h, fs, vs, fsaa = sup_modes[options.cur_fs_mode].width,
							   sup_modes[options.cur_fs_mode].height,
							   options.cur_fullscreen, options.cur_vsync, options.cur_fsaa
	
	if (not cur_fullscreen) then
		w = sup_modes[options.cur_w_mode].width
		h = sup_modes[options.cur_w_mode].height
	end
	
	success = love.graphics.setMode(w,h,fs,vs,fsaa)
	love.onresolutionchange()
end

-- Reposition menu on resolution change
function options.onresolutionchange()
	--Menu position
	options.titlePosX	= 0.05
	options.titlePosY	= 0.075
	options.menuPosX	= 0.28
	options.menuPosY	= 0.26
	if (love.graphics.getWidth() / love.graphics.getHeight()) <= 1.4 then --probably 4:3
		options.titlePosY = options.titlePosY + 0.05
	end
end

-- Fetch current settings to display
function options.fetchsettings()
	local curW, curH, curFS, curVS, curFSAA = love.graphics.getMode()
	--fetch current w_res
	for i=1, #sup_modes, 1 do
		if curW == sup_modes[i].width and curH == sup_modes[i].height then
			options.cur_w_mode = i
		end
	end
	
	--fetch current fs_res
	for i=1, #sup_modes, 1 do
		if curW == sup_modes[i].width and curH == sup_modes[i].height then
			options.cur_fs_mode = i
		end
	end
	
	--fetch current fullscreen bool
	options.cur_fullscreen	= curFS
	if options.cur_fullscreen == true and options.cur_fs_mode > 1 then
		options.cur_w_res = options.cur_fs_res - 1
	end
	
	--fetch current vsync
	options.cur_vsync		= curVS
	
	--fetch current fsaa value
	options.cur_fsaa		= curFSAA
end

--Set the color for selected menu option
function options.set_selected_color(menuItem)

	if cur_option == menuItem then
		love.graphics.setColor( selection_color )
		reset_color = true
	end
end

--Check whether the color should be reset
function options.reset_color()

	if reset_color then
		love.graphics.setColor( menuItem_color )
		reset_color = false
	end
end

--Close the menu
function options.close_menu()
	options.fetchsettings()
	cur_state = state.menu
end

-- Render functions for each option
function options.draw_wres() 	-- 1 -- SHOW WinRes OPTION 
	options.set_selected_color(1)
	
	local str = "<" .. " " .. sup_modes[options.cur_w_mode].width .. "x" .. sup_modes[options.cur_w_mode].height .. " " .. ">"
	love.graphics.print( option_items[1], love.graphics.getWidth()*options.menuPosX, (love.graphics.getHeight()*options.menuPosY) + option_spacing * 1 )
	love.graphics.print( str, (love.graphics.getWidth()*options.menuPosX) + option_xOffset, (love.graphics.getHeight()*options.menuPosY) + option_spacing * 1 )
	
	options.reset_color()
end

function options.draw_fsres() 	-- 2 -- SHOW FullScreenRes OPTION
	options.set_selected_color(2)
	
	local str = "<" .. " " .. sup_modes[options.cur_fs_mode].width .. "x" .. sup_modes[options.cur_fs_mode].height .. " " .. ">"
	love.graphics.print( option_items[2], love.graphics.getWidth()*options.menuPosX, (love.graphics.getHeight()*options.menuPosY) + option_spacing * 2 )
	love.graphics.print( str, (love.graphics.getWidth()*options.menuPosX) + option_xOffset, (love.graphics.getHeight()*options.menuPosY) + option_spacing * 2 )
	
	options.reset_color()
end

function options.draw_vsync() 	-- 3 -- SHOW Vsync OPTION
	options.set_selected_color(3)
	
	local vs = ""
	if options.cur_vsync == true then
		vs = "On"
	else
		vs = "Off"
	end
	
	love.graphics.print( option_items[3], love.graphics.getWidth()*options.menuPosX, (love.graphics.getHeight()*options.menuPosY) + option_spacing * 3 )
	love.graphics.print( vs, (love.graphics.getWidth()*options.menuPosX) + option_xOffset, (love.graphics.getHeight()*options.menuPosY) + option_spacing * 3 )
	
	options.reset_color()
end

function options.draw_fs()		-- 4 -- SHOW FullScreen OPTION
	options.set_selected_color(4)
	
	local fs = ""
	if options.cur_fullscreen == true then
		fs = "On"
	elseif options.cur_fullscreen == false then
		fs = "Off"
	else
		fs = "ERROR! fs = " .. options.cur_fullscreen
	end
	
	love.graphics.print( option_items[4], love.graphics.getWidth()*options.menuPosX, (love.graphics.getHeight()*options.menuPosY) + option_spacing * 4 )
	love.graphics.print( fs, (love.graphics.getWidth()*options.menuPosX) + option_xOffset, (love.graphics.getHeight()*options.menuPosY) + option_spacing * 4 )
	
	options.reset_color()
end

function options.draw_fsaa()	-- 5 -- SHOW FSAA OPTION
	options.set_selected_color(5)
	
	local str = "<" .. options.cur_fsaa .. ">"
love.graphics.print( option_items[5], love.graphics.getWidth()*options.menuPosX, (love.graphics.getHeight()*options.menuPosY) + option_spacing * 5 )
	love.graphics.print( str, (love.graphics.getWidth()*options.menuPosX) + option_xOffset, (love.graphics.getHeight()*options.menuPosY) + option_spacing * 5 )
	
	options.reset_color()
end

function options.draw_apply()	-- 6 -- SHOW APPLY BUTTON
	options.set_selected_color(6)
	
	local str = option_items[6]
	love.graphics.print( str, love.graphics.getWidth()*options.menuPosX, (love.graphics.getHeight()*options.menuPosY) + option_spacing * 7 )
	
	options.reset_color()
end

function options.draw_cancel()	-- 7 -- SHOW CANCEL BUTTON
	options.set_selected_color(7)
	
	local str = option_items[7]
	love.graphics.print( str, love.graphics.getWidth()*options.menuPosX, (love.graphics.getHeight()*options.menuPosY) + option_spacing * 8 )
	
	options.reset_color()
end