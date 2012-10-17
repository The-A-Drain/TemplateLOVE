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
	
	img_Splash 	= love.graphics.newImage( "ui_assets/splash.png" )
	centerX 	= love.graphics:getWidth()/2 --Center the image
	centerY 	= love.graphics:getHeight()/2 
	duration_in		= c.spl_fade_in
	duration_hold	= c.spl_fade_hold -- (seconds) How long the image will be displayed
	duration_out	= c.spl_fade_out
	duration_black_hold = c.spl_hold
	fadeSpeed	= 255 / duration_in -- How fast the image will fade
	opacity		= 0
	state_Fade	= "fading_in" -- fading_in, wait, fading_out
	
	if c.spl_fade == false then -- If config states don't fade, show the splash without fading
		opacity		= 255
		state_Fade = "wait"
		duration_out = 0
	end
end

function splash.update( dt )
	
	if state_Fade 		== "fading_in" then
	
		if fadeSpeed == 0 then
			splash.complete()
		end
	
		opacity = opacity + (fadeSpeed * dt) 	-- Fade the image in
		if opacity >= 255 then
			opacity = 255
			state_Fade = "wait"
		end
	
	elseif state_Fade 	== "wait" then
	
		duration_hold = duration_hold - dt				-- Wait for the image to display
		if duration_hold <= 0 then
			state_Fade = "fading_out"
			fadeSpeed = 255 / duration_out
		end
		
	elseif state_Fade	== "fading_out" then
		
		if fadeSpeed == 0 then
			splash.complete()
		end
		opacity = opacity - (fadeSpeed * dt)	-- Fade the image out
		if opacity <= 0 then
			opacity = 0				-- Signal gamestate that the splash screen is done
			state_Fade = "black_hold"
		end
	elseif state_Fade	== "black_hold" then
		
		duration_black_hold = duration_black_hold - dt
		if duration_black_hold <= 0 then
			splash.complete()
		end
		
	end
end

function splash.draw()

	--Draw the splash image
	love.graphics.setColor( 255, 255, 255, opacity ) -- Set draw opacity to match the desired
	if c.spl_scale then
		-- scale the image based on the scale mode
		draw_scalemode( img_Splash, c.spl_scalemode )
	else -- Draw the un-scaled image in the center
		love.graphics.draw( img_Splash, centerX-img_Splash:getWidth()/2, centerY-img_Splash:getHeight()/2 )
	end
	
	-- Set the splash Font
	love.graphics.setFont( fonts.cBig )
	
	 -- Adjust positioning so it's centered below the image
	textOffset	= love.graphics.getFont():getWidth( label )/2 -- Adjust position from centre by the line width halved
	love.graphics.print( label, centerX - textOffset, centerY + (love.graphics:getHeight()*0.31) )
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