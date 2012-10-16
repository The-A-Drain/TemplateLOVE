-- Simple game template using Love2D written by Adrian Gordon, 2012

-- This template is intended as a very simple starting point
-- for small projects/game jams/etc and may or may not be
-- mildly useful. Use it for whatever you like, including
-- commercial projects. Go nuts.

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

	-- Initialize random generator
	math.randomseed(os.time())
	
	-- Load GUI fonts
	GUIFonts.init()

	--Menu/Frontend states
	started = false
	state = { 
		splash 	= "splash",
		menu 	= "menu",
		options = "options",
		game	= "game",
		pause	= "pause",
		credits = "credits"
	}
	cur_state = state.splash
	
	-- Other load function for includes files go here --
	-- load menu
	splash.init() 	-- Init the splash screen variables
	menu.init() 	-- Init the menu
	options.init() 	-- Init the options menu
	credits.init() 	-- Init the credits screen
	game.init() 	-- Init the game
end

-- Update the current state
function love.update(dt)
	
	if cur_state	== state.splash then
		splash.update(dt)
	end
	
	if cur_state	== state.menu then
		menu.update(dt)
	end
	
	if cur_state	== state.options then
		options.update(dt)
	end
	
	if cur_state	== state.game then
		game.run(dt)
	end
	
	if cur_state	== state.pause then
		--pause.update(dt)
	end
	
	if cur_state	== state.credits then
		credits.update(dt)
	end
	
end

-- Draw function
function love.draw()
	
	if cur_state	== state.splash then
		splash.draw()
	end
	
	if cur_state	== state.menu then
		menu.draw()
	end
	
	if cur_state	== state.options then
		options.draw()
	end
	
	if cur_state	== state.game then
		game.draw()
	end
	
	if cur_state	== state.pause then
		--pause.draw()
	end
	
	if cur_state	== state.credits then
		credits.draw()
	end
end

-- Keypress Function
-- Monitors for key press events and distributes
-- them to the current state
function love.keypressed(key)

	if cur_state	== state.game then 
		game.keypressed(key)
		
	elseif cur_state== state.splash then
		splash.keypressed(key)
		
	elseif cur_state== state.menu then
		menu.keypressed(key)
		
	elseif cur_state== state.options then
		options.keypressed(key)
		
	elseif cur_state== state.credits then
		credits.keypressed(key)
	end
end

-- Mouse Pressed function
-- Monitors for mouse events and sends them to the current state
-- for processing
function love.mousepressed(x,y,k)

	if cur_state	== state.game then 
		game.mousepressed(x,y,k)
		
	elseif cur_state== state.splash then
		splash.mousepressed(x,y,k)
		
	elseif cur_state== state.menu then
		menu.mousepressed(x,y,k)
		
	elseif cur_state== state.options then
		options.mousepressed(x,y,k)
		
	elseif cur_state== state.credits then
		credits.mousepressed(x,y,k)
	end
end

-- Is called when options.lua changes the resolution
-- and updates the other aspects of the menu
function love.onresolutionchange()
	game.onresolutionchange()
	--splash.onresolutionchange()
	menu.onresolutionchange()
	options.onresolutionchange()
	credits.onresolutionchange()
end
