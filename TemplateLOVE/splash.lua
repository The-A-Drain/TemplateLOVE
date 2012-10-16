-- Splash.lua
-- (c) Adrian Gordon 2012
-- A simple splash screen that shows a 
--	logo which fades in and out again

splash = {}

function splash.init()
	label		= "Brainmotron Presents"
	img_Splash 	= love.graphics.newImage( "ui_assets/splash.png" )
	centerX 	= love.graphics:getWidth()/2 --Center the image
	centerY 	= love.graphics:getHeight()/2 
	fadeSpeed	= 500 -- How fast the image will fade
	duration	= 2.0 -- (seconds) How long the image will be displayed
	opacity		= 0
	state_Fade	= "fading_in" -- fading_in, wait, fading_out
end

function splash.update( dt )
	
	if state_Fade 		== "fading_in" then
	
		opacity = opacity + (fadeSpeed * dt) 	-- Fade the image in
		if opacity >= 255 then
			opacity = 255
			state_Fade = "wait"
		end
	
	elseif state_Fade 	== "wait" then
	
		duration = duration - dt				-- Wait for the image to display
		if duration <= 0 then
			state_Fade = "fading_out"
		end
		
	elseif state_Fade	== "fading_out" then
	
		opacity = opacity - (fadeSpeed * dt)	-- Fade the image out
		if opacity <= 0 then
			opacity = 0				-- Signal gamestate that the splash screen is done
			splash.complete()
		end
	end
end

function splash.draw()

	--Draw the splash image
	love.graphics.setColor( 255, 255, 255, opacity ) -- Set draw opacity to match the desired
	love.graphics.draw( img_Splash, centerX-img_Splash:getWidth()/2, centerY-img_Splash:getHeight()/2 )
	
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