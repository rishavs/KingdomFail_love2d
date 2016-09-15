local GUI = {}

------------------------------------------------
-- Componants
------------------------------------------------

Map = require "src.MapGenerator"

------------------------------------------------
-- Declarations
------------------------------------------------


------------------------------------------------
-- Module Definition: HUD
------------------------------------------------

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
        elseif settings_btn.hit then
            Gamestate.switch(_state_Settings)
        elseif quit_btn.hit then
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
        UI.layout:reset(10, 20)
        UI.layout:padding(20,20)
        mainMenu_btn = UI.Button("Menu",UI.layout:col(100,30))
        seed_btn = UI.Button("Seed", UI.layout:col(100,30))
        seed_lbl = UI.Label("Random Seed = " .. tostring(seed), UI.layout:col(100,30))

        -- Define behavior of UI elements
        ------------------------------------------------
        if mainMenu_btn.hit then
            Gamestate.switch(_state_MainMenu)
        elseif seed_btn.hit then
            seed = Map.generate_seed()
            map_obj = Map.generate_map(seed, grid_size, cell_size)
        end
    end

end

return GUI
