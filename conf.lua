function love.conf(t)
	--Basic setup stuff
	t.title				= "TemplateLOVE"
	t.author			= "Adrian Gordon"
	t.url				= "" --The website URL of the game
	
	--App identity and LOVE2D version
	t.identity			= "tutorials"
	t.console			= false
	t.release			= false --Set to true for release mode
	t.version			= "0.8.0"
	
	--Screen dimensions and settings
	t.fullscreen		= false
	t.screen.width		= 1024
	t.screen.height		= 768
	
	t.screen.vsync		= true
	t.screen.fsaa		= 0
	
	--Enable/Disable modules as needed, disabled slightly reduces startup
	t.modules.joystick	= false
	t.modules.audio		= true
	t.modules.keyboard	= true
	t.modules.event		= true
	t.modules.image		= true
	t.modules.graphics	= true
	t.modules.timer		= true
	t.modules.mouse		= true
	t.modules.sound		= true
	t.modules.physics	= false
end