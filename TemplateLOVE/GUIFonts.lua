-- A simple lua file that initializes a group of GUIFonts
-- for the GUI to use
GUIFonts = {}

function GUIFonts.init()
	fonts = {
		-- Normal Font
		nSmall		= love.graphics.newFont( "fonts/regular.ttf", 16 ),
		nMedium		= love.graphics.newFont( "fonts/regular.ttf", 21 ),
		nBig		= love.graphics.newFont( "fonts/regular.ttf", 36 ),
		-- Pixel Font
		pSmall		= love.graphics.newFont( "fonts/pixel.ttf", 31 ),
		pMedium		= love.graphics.newFont( "fonts/pixel.ttf", 56 ),
		pBig		= love.graphics.newFont( "fonts/pixel.ttf", 115 ),
		-- Company Font
		cSmall		= love.graphics.newFont( "fonts/company.ttf", 16 ),
		cMedium		= love.graphics.newFont( "fonts/company.ttf", 21 ),
		cBig		= love.graphics.newFont( "fonts/company.ttf", 36 )
	}
end