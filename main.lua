
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
    Gamestate.registerEvents()
    Gamestate.switch(_state_MainMenu)
    
    -- updating the theme colors
    -- UI.theme.color.normal.fg = {255,255,255}
    -- UI.theme.color.hovered = {bg = {150,150,150}, fg = {0,0,0}}
    -- UI.theme.color.active = {bg = {250,250,250}, fg = {0,0,0}}
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
