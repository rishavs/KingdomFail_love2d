local _state_WorldGen = {}

------------------------------------------------
-- Declarations
------------------------------------------------

local slider = {value = 3000, min = 1000, max = 9999}

------------------------------------------------
-- State Definition: _state_WorldGen
------------------------------------------------
function _state_WorldGen:init()
    GUI:init()
end

function _state_WorldGen:draw()
    love.graphics.print("State: _state_WorldGen", scrWidth-300, 10)

    GUI:draw()
end

function _state_WorldGen:update(dt)

    GUI:update()


    -- UI.Slider(slider, 100,100, 200,20)
    -- UI.Label("Seed = " .. tostring(Utils.round(slider.value)), 300,100, 200,20)

end

function _state_WorldGen:keyreleased(key)
    if key == 'return' then
        Gamestate.switch(_state_MainMenu)
    end
end

return _state_WorldGen