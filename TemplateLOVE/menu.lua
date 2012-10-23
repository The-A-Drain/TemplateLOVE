-- Menu.lua 
-- (c) 2012 Adrian Gordon
-- A simple functional menu designed as a
--  template to be expanded upon
menu = {}

function menu.init()

	
	
	menu_items = {
		"Start",
		--"Options",
		--"Credits",
		"Quit"
	}
	
	if c.menu_showOptions then
		table.insert( menu_items, #menu_items, "Options" )
	end
	
	if c.menu_showCredits then
		table.insert( menu_items, #menu_items, "Credits" )
	end
	
	menu.cur_selection 		= 1
	menu.title_color			= { 222, 222, 222, 255 }
	menu.menuItem_color		= { 170, 170, 170, 255 }
	menu.selection_color		= { 255, 255, 255, 255 }
	menu.verticalTextOffset 	= 48
	
	
	menu.title				= love.graphics.getCaption()
	if not c.menu_useCaption then
		menu.title = c.menu_gamemenu.title
	end
	
	menu.titleX				= 0
	menu.titleY				= 0
	menu.menuYPos			= 0
	menu.menuXPos			= 0
	menu.font 			= fonts.pMedium
	menu.mouseover		= false;
	menu.onresolutionchange()
	
	menu.title_bg			= love.graphics.newImage( "ui_assets/title/title_bg.png")
end

function menu.update()

	if not c.use_mouse then
		return nil
	end
	-- Check the current mouse position
	local mx, my = love.mouse.getPosition()
	
	-- If the mouse hasn't moved, bail
	if mx == previous_mouse_x and my == previous_mouse_y then
		return nil
	end
	
	menu.mouseover = false;
	for i=1, #menu_items, 1 do
		 --menu.menuXPos, menu.menuYPos + (menu.verticalTextOffset * (i-1))
		 if menu.checkbutton_mouseover(mx, my,
							 menu.menuXPos, 
							 menu.menuYPos + (menu.verticalTextOffset * (i-1)),
							 menu.font:getWidth(menu_items[i]),
							 menu.font:getHeight(menu_items[i]) )  then
			menu.cur_selection = i
			menu.mouseover = true;
		 end
	end
	
	
end

function menu.checkbutton_mouseover(x1, y1, x2, y2, w2, h2)
	if x1 > x2 and x1 < x2+w2 and 
	   y1 > y2 and y1 < y2+h2 then return true end
	return false
end

function menu.onresolutionchange()
	
	menu.titleX				= love.graphics:getWidth()/2
	menu.titleY				= love.graphics:getHeight()*0.10
	menu.menuYPos			= love.graphics:getHeight()*0.41
	menu.menuXPos			= love.graphics:getWidth()*0.21
	
	if (love.graphics.getWidth() / love.graphics.getHeight()) <= 1.4 then --probably 4:3
		menu.titleY = menu.titleY + love.graphics:getHeight()*0.10
	end
	--print ("reschange_menu")
end

function menu.draw()

	-- Reset color
	love.graphics.setColor( 255, 255, 255, 255 )
	
	-- Draw the menu.title background
	-- at current resolution
	if c.menu_scalebg then
		draw_scalemode( menu.title_bg, c.menu_scalemode )
	else
		love.graphics.draw( menu.title_bg, 0, 0, math.rad(0), love.graphics.getWidth()/menu.title_bg:getWidth(), love.graphics.getHeight()/menu.title_bg:getHeight(), 0, 0 )
	end
	
	love.graphics.setFont( fonts.nMedium )
	
	-- Draw the game menu.title
	love.graphics.setFont( fonts.pBig )
	love.graphics.setColor( menu.title_color )
	love.graphics.print( menu.title, menu.titleX - love.graphics.getFont():getWidth( menu.title )/2, menu.titleY )
	
	-- Draw the menu itself
	love.graphics.setFont( menu.font )
	
	for i=1, #menu_items, 1 do

		if i == menu.cur_selection then
			love.graphics.setColor( menu.selection_color )
		else
			love.graphics.setColor( menu.menuItem_color )
		end
		love.graphics.print( menu_items[i], menu.menuXPos, menu.menuYPos + (menu.verticalTextOffset * (i-1)) )
	end
end

-- Process the user selection 
function menu.process_option()
	local str	= menu_items[menu.cur_selection]
	if str == "Start" then		-- START
		cur_state = state.game
	
	elseif str == "Options" then	-- OPTIONS
		cur_state = state.options
	
	elseif str == "Credits" then	-- CREDITS
		cur_state = state.credits
	
	elseif str == "Quit" then	-- QUIT
		love.event.push("quit")
	end
end

function menu.keypressed(key)

	-- Menu selection
	if key == "up" then
		menu.cur_selection = menu.cur_selection - 1
	elseif key == "down" then
		menu.cur_selection = menu.cur_selection + 1
	end
	-- Menu wrap-around
	if menu.cur_selection > #menu_items then
		menu.cur_selection = 1
	elseif menu.cur_selection < 1 then
		menu.cur_selection = #menu_items
	end
	
	-- User confirmation
	if key == ' ' or key == 'return' then
		menu.process_option()	
	end
	
	-- Quit key
	if key == 'escape' then
		menu.cur_selection = 4
		menu.process_option()
	end
	
end

function menu.mousepressed(x,y,k)
	if menu.mouseover and k == "l" then
		menu.process_option()
	end
end