
------------------------------------------------
-- libs
------------------------------------------------
Gamestate = require "libs.hump.gamestate"
Camera = require "libs.hump.camera"
UI = require "libs.SUIT"
Inspect = require 'libs.inspect.inspect'

------------------------------------------------
-- Componants
------------------------------------------------
Utils = require "src.Utils"
_state_MainMenu = require "src._state_MainMenu"
_state_Settings = require "src._state_Settings"

------------------------------------------------
-- Declarations
------------------------------------------------


------------------------------------------------
-- Base functions
------------------------------------------------
function love.load()
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
