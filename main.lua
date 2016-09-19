
------------------------------------------------
-- libs
------------------------------------------------
Gamestate = require "libs.hump.gamestate"
Camera = require "libs.hump.camera"
UI = require "libs.SUIT"
Inspect = require 'libs.inspect.inspect'
json = require 'libs.json.json'

------------------------------------------------
-- Componants
------------------------------------------------

_state_MainMenu = require "src._state_MainMenu"
_state_Settings = require "src._state_Settings"
_state_WorldGen = require "src._state_WorldGen"

------------------------------------------------
-- Declarations
------------------------------------------------
scrWidth = love.graphics.getWidth()
scrHeight = love.graphics.getHeight()


------------------------------------------------
-- Base functions
------------------------------------------------
function love.load()
    love.math.setRandomSeed(os.time())

    Gamestate.registerEvents()
    Gamestate.switch(_state_MainMenu)
end

function love.quit()

end


------------------------------------------------
-- Custom functions
------------------------------------------------

------------------------------------------------
-- Utils. Toolbelt stuff needed to run this app
------------------------------------------------

------------------------------------------------
-- Debug. Stuff here gets removed after debugging is done
------------------------------------------------
