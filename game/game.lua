-- Game State
-- (c) Adrian Gordon 2012
-- Simple placeholder game state

game = {}

function game.init()
end

function game.run()
end

function game.draw()
	love.graphics.setFont( fonts.nSmall )
	love.graphics.setColor( 255, 255, 255, 255 )
	love.graphics.print( "Replace game.lua with your own \ncode and it will launch here\n\nPress Escape to quit...", 10, 50 )
end

function game.keypressed(key)
	if key == 'escape' then
	love.event.push('quit')
	end
end

function game.mousepressed(x,y,k)
end

function game.onresolutionchange()
end