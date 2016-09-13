local _state_Settings = {}

------------------------------------------------
-- State Definition: _state_Settings
------------------------------------------------
function _state_Settings:init()
    GUI:init()
end

function _state_Settings:draw()
    love.graphics.print("State: _state_Settings", scrWidth-300, 10)
    love.graphics.print("Press ENTER to return", scrWidth-300, 30)

    GUI:draw()
    -- UI.draw()
end

function _state_Settings:update(dt)
    GUI:update()
end

function _state_Settings:keyreleased(key)
    if key == 'return' then
        print("ENTER")
        Gamestate.switch(_state_MainMenu)
    end
end

return _state_Settings