function templatelove_conf(c)
	-- Set each value to your preference, or leave them at the default value.
	
	-- General Config
	c.show_splash	= true -- Whether or not to display a splash screen
	
	-- Background image options
	
	
	-- Control Config
	-- Use at least one of these
	c.use_mouse		= true -- Use mouse controls
	c.use_keyboard	= true -- Use keyboard controls, arrow keys to navigate
	c.kbd_accept	= "return"
	c.kbd_back		= "escape"
	
	-- Splash Screen
	c.spl_scale		= true -- Should the plash image be scaled to fit the screen?
	c.spl_scalemode = "fit-width" -- "stretch-to-fit", "fit-width" or "fit-height"
	c.spl_fade		= true 	-- Whether or not the splash screen should fade
	c.spl_fade_in	= 0.5 	-- How long the splash should take to fade in
	c.spl_fade_hold	= 1.25	-- show at full opacity
	c.spl_fade_out	= 0.25	-- and fade out again
	c.spl_hold		= 0.1	-- how long to hold on black screen before moving to the menu
	c.spl_showTxt	= true	-- Should the splash screen show any text?
	c.spl_txt		= "Ludophobia Presents" -- The text that will be shown
	
	-- Menu Screen
	c.menu_scalebg		= true -- will stretch to fit by default
	c.menu_scalemode	= "fit-width" -- "fit-width" or "fit-height"
	c.menu_useCaption 	= true -- If true, t.title from conf.lua will be used as the games title
	c.menu_gameTitle	= "TemplateLOVE" -- Otherwise this title will be used
	c.menu_showOptions	= true -- Show the options menu button
	c.menu_showCredits	= true -- Show the credits menu button
	
	-- Options Menu //NOT IMPLEMENTED YET
	
	-- Credits Screen 
	c.cred_scroll	= true 	-- True: Credits will scroll, False: They won't scroll
	c.cred_speed	= 30	-- Scroll speed
end