local GUI = {}

function GUI:init()

end

function GUI:draw()
    UI.draw()
end

function GUI:update(dt)
    
    ------------------------------------------------
    -- Define UI elements for _state_MainMenu
    ------------------------------------------------

    if Gamestate.current() == _state_MainMenu then
        UI.layout:reset(scrWidth/2 - 50, scrHeight/2 - 100)
        UI.layout:padding(20,20)
        
        new_world_btn = UI.Button("New World", UI.layout:row(100,30))
        settings_btn = UI.Button("Settings", UI.layout:row(100,30))
        quit_btn = UI.Button("Quit", UI.layout:row(100,30))

        -- Define behavior of UI elements
        ------------------------------------------------
        if new_world_btn.hit then
            Gamestate.switch(_state_WorldGen)
        end        

        if settings_btn.hit then
            Gamestate.switch(_state_Settings)
        end

        if quit_btn.hit then
            love.event.quit()
        end
    
    ------------------------------------------------
    -- Define UI elements for _state_Settings
    ------------------------------------------------
    elseif Gamestate.current() == _state_Settings then
        -- UI.layout:reset(scrWidth/2 - 50, scrHeight/2 - 100)
        -- UI.layout:padding(20,20)
        mainMenu_btn = UI.Button("Menu", 10, 20, 100, 30)


        -- Define behavior of UI elements
        ------------------------------------------------
        if mainMenu_btn.hit then
            Gamestate.switch(_state_MainMenu)
        end
        
    ------------------------------------------------
    -- Define UI elements for _state_WorldGen
    ------------------------------------------------
    elseif Gamestate.current() == _state_WorldGen then
        -- UI.layout:reset(scrWidth/2 - 50, scrHeight/2 - 100)
        -- UI.layout:padding(20,20)
        mainMenu_btn = UI.Button("Menu", 10, 20, 100, 30)
        
        -- Define behavior of UI elements
        ------------------------------------------------
        if mainMenu_btn.hit then
            Gamestate.switch(_state_MainMenu)
        end
        
    end

end

return GUI

