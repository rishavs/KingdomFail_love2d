local _state_MainMenu = {}

------------------------------------------------
-- State Definition: _state_MainMenu
------------------------------------------------

function _state_MainMenu:init()

end

function _state_MainMenu:draw()
    love.graphics.print("State: _state_MainMenu", 10, 10)
    love.graphics.print("Press ENTER to goto Settings", 10, 30)
    
    UI.draw()

end

function _state_MainMenu:update(dt)
    UI.layout:reset(scrWidth/2 - 50, scrHeight/2 - 100)
    UI.layout:padding(20,20)
    
    
    new_world_btn = UI.Button("New World", UI.layout:row(100,30))
    if new_world_btn.hit then
        Gamestate.switch(_state_WorldGen)
    end        

    if UI.Button("Settings", UI.layout:row(100,30)).hit then
        Gamestate.switch(_state_Settings)
    end

    if UI.Button("Quit", UI.layout:row(100,30)).hit then
        love.event.quit()
    end
    
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