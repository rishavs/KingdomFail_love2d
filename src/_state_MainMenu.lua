local _state_MainMenu = {}

------------------------------------------------
-- State Definition: _state_MainMenu
------------------------------------------------

function _state_MainMenu:init()
    GUI:init()
end

function _state_MainMenu:draw()

    love.graphics.print("State: _state_MainMenu", scrWidth-300, 10)
    love.graphics.print("Press ENTER to goto Settings", 10, 30)

    -- HUD:draw()
    GUI:draw()

end

function _state_MainMenu:update(dt)
    GUI:update()
    
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