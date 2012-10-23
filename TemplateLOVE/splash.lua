-- Splash.lua
-- (c) Adrian Gordon 2012
-- A simple splash screen that shows a 
--	logo which fades in and out again

splash = {}

function splash.init()

	if c.show_splash == false then
		splash.complete()
		return nil
	end
	
	label = "" -- Read label from config
	if c.spl_showTxt then
		label		= c.spl_txt
	end
	
	splash.img_Splash 	= love.graphics.newImage( "ui_assets/splash.png" )
	splash.centerX 	= love.graphics:getWidth()/2 --Center the image
	splash.centerY 	= love.graphics:getHeight()/2 
	splash.duration_in		= c.spl_fade_in
	splash.duration_hold	= c.spl_fade_hold -- (seconds) How long the image will be displayed
	splash.duration_out	= c.spl_fade_out
	splash.duration_black_hold = c.spl_hold
	splash.fadeSpeed	= 255 / splash.duration_in -- How fast the image will fade
	splash.opacity		= 0
	splash.state_Fade	= "fading_in" -- fading_in, wait, fading_out
	
	if c.spl_fade == false then -- If config states don't fade, show the splash without fading
		splash.opacity		= 255
		splash.state_Fade = "wait"
		splash.duration_out = 0
	end
end

function splash.update( dt )
	
	if splash.state_Fade 		== "fading_in" then
	
		if splash.fadeSpeed == 0 then
			splash.complete()
		end
	
		splash.opacity = splash.opacity + (splash.fadeSpeed * dt) 	-- Fade the image in
		if splash.opacity >= 255 then
			splash.opacity = 255
			splash.state_Fade = "wait"
		end
	
	elseif splash.state_Fade 	== "wait" then
	
		splash.duration_hold = splash.duration_hold - dt				-- Wait for the image to display
		if splash.duration_hold <= 0 then
			splash.state_Fade = "fading_out"
			splash.fadeSpeed = 255 / splash.duration_out
		end
		
	elseif splash.state_Fade	== "fading_out" then
		
		if splash.fadeSpeed == 0 then
			splash.complete()
		end
		splash.opacity = splash.opacity - (splash.fadeSpeed * dt)	-- Fade the image out
		if splash.opacity <= 0 then
			splash.opacity = 0				-- Signal gamestate that the splash screen is done
			splash.state_Fade = "black_hold"
		end
	elseif splash.state_Fade	== "black_hold" then
		
		splash.duration_black_hold = splash.duration_black_hold - dt
		if splash.duration_black_hold <= 0 then
			splash.complete()
		end
		
	end
end

function splash.draw()

	--Draw the splash image
	love.graphics.setColor( 255, 255, 255, splash.opacity ) -- Set draw splash.opacity to match the desired
	if c.spl_scale then
		-- scale the image based on the scale mode
		draw_scalemode( splash.img_Splash, c.spl_scalemode )
	else -- Draw the un-scaled image in the center
		love.graphics.draw( splash.img_Splash, splash.centerX-splash.img_Splash:getWidth()/2, splash.centerY-splash.img_Splash:getHeight()/2 )
	end
	
	-- Set the splash Font
	love.graphics.setFont( fonts.cBig )
	
	 -- Adjust positioning so it's centered below the image
	textOffset	= love.graphics.getFont():getWidth( label )/2 -- Adjust position from centre by the line width halved
	love.graphics.print( label, splash.centerX - textOffset, splash.centerY + (love.graphics:getHeight()*0.31) )
end

function splash.keypressed( key )
	if key == ' ' or key == 'return' or key == 'escape' then
		splash.complete()
	end
end

function splash.mousepressed( x,y,k )
	splash.complete()
end

function splash.complete() -- CHANGE GAME STATE TO MENU --
	cur_state = state.menu
end