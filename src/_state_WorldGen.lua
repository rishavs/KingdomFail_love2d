local _state_WorldGen = {}

------------------------------------------------
-- Declarations
------------------------------------------------

local slider = {value = 3000, min = 1000, max = 9999}

------------------------------------------------
-- State Definition: _state_WorldGen
------------------------------------------------
function _state_WorldGen:init()

end

function _state_WorldGen:draw()


    UI.draw()
end

function _state_WorldGen:update(dt)
    if UI.Button("Menu", 10, 20, 100,30).hit then
        Gamestate.switch(_state_MainMenu)
    end
    


    UI.Slider(slider, 100,100, 200,20)
    UI.Label("Seed = " .. tostring(Utils.round(slider.value)), 300,100, 200,20)

end

function _state_WorldGen:keyreleased(key)
    if key == 'return' then
        Gamestate.switch(_state_MainMenu)
    end
end

return _state_WorldGen