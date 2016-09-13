local _state_Settings = {}

------------------------------------------------
-- State Definition: _state_Settings
------------------------------------------------
function _state_Settings:init()

end

function _state_Settings:draw()
    love.graphics.print("State: _state_Settings", scrWidth-300, 10)
    love.graphics.print("Press ENTER to return", scrWidth-300, 30)

    UI.draw()
end

function _state_Settings:update(dt)
    if UI.Button("Menu", 10, 20, 100,30).hit then
        Gamestate.switch(_state_MainMenu)
    end
end

function _state_Settings:keyreleased(key)
    if key == 'return' then
        print("ENTER")
        Gamestate.switch(_state_MainMenu)
    end
end

return _state_Settings