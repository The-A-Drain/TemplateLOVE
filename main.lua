-- Simple game template using Love2D written by Adrian Gordon, 2012

-- This template is intended as a very simple starting point
-- for small projects/game jams/etc and may or may not be
-- mildly useful. Use it for whatever you like, including
-- commercial projects. Go nuts.

-- TemplateLove conf
require "templatelove_conf"

-- Game includes
require "TemplateLOVE/splash"
require "TemplateLOVE/menu"
require "TemplateLOVE/options"
require "TemplateLOVE/credits"
require "game/game"

-- misc includes
require "TemplateLOVE/GUIFonts"


-- The first thing the LOVE2D engine calls after conf.lua
function love.load()

	-- Get config options
	c = {}
	templatelove_conf(c)

	-- Initialize random generator
	math.randomseed(os.time())
	
	-- Load GUI fonts
	GUIFonts.init()

	--Menu/Frontend states
	started = false
	state = { 
		splash 	= splash,
		menu 	= menu,
		options = options,
		game	= game,
		pause	= pause,
		credits = credits
	}
	cur_state = splash
	
	-- Other load function for includes files go here --
	-- load menu
	splash.init() 	-- Init the splash screen variables
	menu.init() 	-- Init the menu
	options.init() 	-- Init the options menu
	credits.init() 	-- Init the credits screen
	game.init() 	-- Init the game
	
	-- Mouse position at the end of each frame
	previous_mouse_x = 0;
	previous_mouse_y = 0;
	
	-- Disable default mouse
	cursor = love.graphics.newImage("ui_assets/cursor.png")
	love.mouse.setVisible(false)
	love.mouse.setGrab(false)
end

-- Update the current state
function love.update(dt)
	
	if cur_state then
		cur_state.update(dt)
	end
	
	previous_mouse_x, previous_mouse_y = love.mouse.getPosition()
end

-- Draw function
function love.draw()

	
	
	if cur_state  then
		cur_state.draw()
	end
	
	-- Draw the mouse cursor on top
	love.drawcursor()
end

function love.drawcursor()
	love.graphics.draw(cursor, love.mouse.getX(), love.mouse.getY() )
end

-- Keypress Function
-- Monitors for key press events and distributes
-- them to the current state
function love.keypressed(key)

	if not c.use_keyboard and not (cur_state == game) then
		return nil
	end

	if cur_state  then 
		cur_state.keypressed(key)
	end

end

-- Mouse Pressed function
-- Monitors for mouse events and sends them to the current state
-- for processing
function love.mousepressed(x,y,k)

	if not c.use_mouse and not (cur_state == game) then
		return nil
	end

	if cur_state then 
		cur_state.mousepressed(x,y,k)
	end
	
end

-- Is called when options.lua changes the resolution
-- and updates the other aspects of the menu
function love.onresolutionchange()
	--splash.onresolutionchange()
	menu.onresolutionchange()
	options.onresolutionchange()
	--game.resolutionchanged()
	--pause	= pause,
	credits.onresolutionchange()
end

-- Stretch the rectangle to fit the screen
function stretch_to_fit(w, h)
	return love.graphics.getWidth(), love.graphics.getHeight()
end

-- Scale the rectangle to fit the screen width (letterbox if necessary)
function fit_width(w, h)
	ratio = w/h
	w = love.graphics.getWidth()
	h = math.floor( w / ratio )
	
	return w, h
end

-- Scale the rectangle to fit the screen height (pillarbox if necessary)
function fit_height(w, h)
	ratio = w/h
	h = love.graphics.getHeight()
	w = math.floor( h * ratio )
	return w, h
end

function draw_scalemode( img, s_mode )

	if s_mode == "fit-width" then
		local w, h = fit_width(img:getWidth(), img:getHeight())
		love.graphics.draw( img, 0, ( love.graphics.getHeight() - h )/2, 0, w/img:getWidth(), h/img:getHeight( ) )
		
	elseif s_mode == "fit-height" then
		local w, h = fit_height(img_Splash:getWidth(), img_Splash:getHeight() )
		love.graphics.draw( img, ( love.graphics.getWidth() - w )/2, 0, 0, w/img:getWidth(), h/img:getHeight( ) )
		
	else -- must be stretch to fill
		love.graphics.draw( img, 0, 0, 0, love.graphics.getWidth()/img:getWidth(), love.graphics.getHeight()/img:getHeight() )
	end		

end
