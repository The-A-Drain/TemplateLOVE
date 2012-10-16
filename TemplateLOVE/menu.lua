-- Menu.lua 
-- (c) 2012 Adrian Gordon
-- A simple functional menu designed as a
--  template to be expanded upon
menu = {}

function menu.init()
	
	menu_items = {
		"Start",
		"Options",
		"Credits",
		"Quit"
	}
	
	cur_selection 		= 1
	title_color			= { 222, 222, 222, 255 }
	menuItem_color		= { 170, 170, 170, 255 }
	selection_color		= { 255, 255, 255, 255 }
	verticalTextOffset 	= 48
	title				= love.graphics.getCaption()
	titleX				= 0
	titleY				= 0
	menuYPos			= 0
	menuXPos			= 0
	menu.font 			= fonts.pMedium
	menu.mouseover		= false;
	menu.onresolutionchange()
	
	title_bg			= love.graphics.newImage( "ui_assets/title/title_bg.png")
end

function menu.update()
	-- Check the current mouse position
	local mx, my = love.mouse.getPosition()
	menu.mouseover = false;
	for i=1, #menu_items, 1 do
		 --menuXPos, menuYPos + (verticalTextOffset * (i-1))
		 if menu.checkbutton_mouseover(mx, my,
							 menuXPos, 
							 menuYPos + (verticalTextOffset * (i-1)),
							 menu.font:getWidth(menu_items[i]),
							 menu.font:getHeight(menu_items[i]) )  then
			cur_selection = i
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
	
	titleX				= love.graphics:getWidth()/2
	titleY				= love.graphics:getHeight()*0.10
	menuYPos			= love.graphics:getHeight()*0.41
	menuXPos			= love.graphics:getWidth()*0.21
	
end

function menu.draw()

	-- Reset color
	love.graphics.setColor( 255, 255, 255, 255 )
	
	-- Draw the title background
	-- at current resolution
	love.graphics.draw( title_bg, 0, 0, math.rad(0), love.graphics.getWidth()/title_bg:getWidth(), love.graphics.getHeight()/title_bg:getHeight(), 0, 0 )
	love.graphics.setFont( fonts.nMedium )
	
	-- Draw the game title
	love.graphics.setFont( fonts.pBig )
	love.graphics.setColor( title_color )
	love.graphics.print( title, titleX - love.graphics.getFont():getWidth( title )/2, titleY )
	
	-- Draw the menu itself
	love.graphics.setFont( menu.font )
	
	for i=1, #menu_items, 1 do

		if i == cur_selection then
			love.graphics.setColor( selection_color )
		else
			love.graphics.setColor( menuItem_color )
		end
		love.graphics.print( menu_items[i], menuXPos, menuYPos + (verticalTextOffset * (i-1)) )
	end
end

-- Process the user selection 
function menu.process_option()
	if cur_selection == 1 then		-- START
		cur_state = state.game
	
	elseif cur_selection == 2 then	-- OPTIONS
		cur_state = state.options
	
	elseif cur_selection == 3 then	-- CREDITS
		cur_state = state.credits
	
	elseif cur_selection == 4 then	-- QUIT
		love.event.push("quit")
	end
end

function menu.keypressed(key)

	-- Menu selection
	if key == "up" then
		cur_selection = cur_selection - 1
	elseif key == "down" then
		cur_selection = cur_selection + 1
	end
	-- Menu wrap-around
	if cur_selection > #menu_items then
		cur_selection = 1
	elseif cur_selection < 1 then
		cur_selection = #menu_items
	end
	
	-- User confirmation
	if key == ' ' or key == 'return' then
		menu.process_option()	
	end
	
	-- Quit key
	if key == 'escape' then
		cur_selection = 4
		menu.process_option()
	end
	
end

function menu.mousepressed(x,y,k)
	if menu.mouseover and k == "l" then
		menu.process_option()
	end
end