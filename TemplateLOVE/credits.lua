-- Credits Screen
-- (c) Adrian Gordon 2012
-- Simple scrolling credit screen

credits = {}

function credits.init()
	--Init Credit fonts/sizes/colours
	
	-- Movement vars
	credits.scrollspeed = 25
	credits.y_pos = love.graphics.getHeight()/2
	credits.scrollfinished = false;
	
	-- Positioning vars
	credits.y_prespace_title	= 120
	credits.y_space_title		= 100
	credits.y_prespace_header	= 40
	credits.y_space_header		= 60
	credits.y_space_name		= 35
	
	credit_table = {}
	
	--read from credits.txt
	for line in love.filesystem.lines("ui_assets/credits/credits.txt") do
		print(line)
		table.insert(credit_table, line)
	end
end

-- Reset the credit roll to be viewed from the top again
function credits.reset()
end

-- Update function
function credits.update(dt)
	-- Scroll the credits up the screen
	credits.y_pos = credits.y_pos - credits.scrollspeed * dt
	
	-- If the credit roll is finished, exit
	if scrollfinished == true then
		credits.close()
	end
end

function credits.draw()
	--temp
	love.graphics.setFont( fonts.cBig )
	love.graphics.setColor( title_color )
	local str = "CREDITS"
	local ln  = "---------"
	love.graphics.print( str, love.graphics.getWidth()/2-love.graphics.getFont():getWidth( str )/2, credits.y_pos )
	love.graphics.print( ln, love.graphics.getWidth()/2-love.graphics.getFont():getWidth( ln )/2, credits.y_pos + love.graphics.getFont():getHeight(str) )
	
	local cx = love.graphics.getWidth()/2
	local cy = credits.y_pos
	
	--Display credits from the table parsing the txt
	for ref, credit in ipairs(credit_table) do
				
		local str, repl = "",0
		
		str, repl = string.gsub( credit, "<title>", "" )
		if repl == 1 then	-- It's a title
			
			love.graphics.setFont( fonts.cBig )
			cy = cy + credits.y_prespace_title
			love.graphics.print( str, cx-love.graphics.getFont():getWidth( str )/2, cy )
			cy = cy + credits.y_space_title
		end
		
		str, repl = string.gsub( credit, "<heading>", "")			
		if repl == 1 then
			
			love.graphics.setFont( fonts.cMedium )
			cy = cy + credits.y_prespace_header
			love.graphics.print( str, cx-love.graphics.getFont():getWidth( str )/2, cy )
			cy = cy + credits.y_space_header
		end
			
		str, repl = string.gsub( credit, "<name>", "")					
		if repl == 1 then
			
			love.graphics.setFont( fonts.cSmall )
			love.graphics.print( str, cx-love.graphics.getFont():getWidth( str )/2, cy )
			cy = cy + credits.y_space_name
		end		
	end
	
	-- check to see if the credits are finished
	-- by comparing the current cy (bottom of credits)
	-- to the top of the screen
	if cy <= 0 then
		credits.close()
	end
end

-- Process key events
function credits.keypressed(key)

	if key == 'escape' then -- Exit back out to the menu
		credits.close()
	end
end

-- Process mouse events
function credits.mousepressed(x,y,k)
end

-- Reset the credit scroller on exit or completion
function credits.reset()
	credits.y_pos = love.graphics.getHeight()/2
	credits.scrollfinished = false;
end

-- Close the credits and return to the main menu
function credits.close()
	credits.reset()
	cur_state = state.menu
end

-- Any necessary updates that must take place when
-- the resolution is changed
function credits.onresolutionchange()
end