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
	if cur_state then 
		cur_state.onresolutionchange()
	end
end
