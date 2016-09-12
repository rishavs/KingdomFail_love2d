local _state_MainMenu = {}

------------------------------------------------
-- State Definition: _state_MainMenu
------------------------------------------------

function _state_MainMenu:init()

end

function _state_MainMenu:draw()
    love.graphics.print("State: _state_MainMenu", 10, 10)
    love.graphics.print("Press ENTER to goto Settings", 10, 30)

end

function _state_MainMenu:update(dt)

end


function _state_MainMenu:keyreleased(key)
    if key == 'return' then
        Gamestate.switch(_state_Settings)
    end    
    
    if key == 'escape' then
        love.event.quit()
    end
end

return _state_MainMenu