local GUI = {}

------------------------------------------------
-- State Definition: GUI
------------------------------------------------


function GUI:init()
    -- updating the theme colors
    -- UI.theme.color.normal.fg = {255,255,255}
    -- UI.theme.color.hovered = {bg = {150,150,150}, fg = {0,0,0}}
    -- UI.theme.color.active = {bg = {250,250,250}, fg = {0,0,0}}
    

    
end

function GUI:draw()
    UI.draw()
end

function GUI:update(dt)
    
    ------------------------------------------------
    -- Define UI elements for each view
    ------------------------------------------------

    if Gamestate.current() == _state_MainMenu then
        UI.layout:reset(scrWidth/2 - 50, scrHeight/2 - 100)
        UI.layout:padding(20,20)
        
        new_world_btn = UI.Button("New World", UI.layout:row(100,30))
        settings_btn = UI.Button("Settings", UI.layout:row(100,30))
        quit_btn = UI.Button("Quit", UI.layout:row(100,30))
        
    elseif Gamestate.current() == _state_Settings then
        UI.layout:reset(scrWidth/2 - 50, scrHeight/2 - 100)
        UI.layout:padding(20,20)
        mainMenu_btn = UI.Button("Menu", UI.layout:row(100,30))
        
    elseif Gamestate.current() == _state_WorldGen then
        UI.layout:reset(scrWidth/2 - 50, scrHeight/2 - 100)
        UI.layout:padding(20,20)
        mainMenu_btn = UI.Button("Menu", UI.layout:row(100,30))
        
    end

    ------------------------------------------------
    -- Define behavior of UI elements
    ------------------------------------------------
  
    if mainMenu_btn and mainMenu_btn.hit then
        Gamestate.switch(_state_MainMenu)
    end
    
    if new_world_btn and new_world_btn.hit then
        Gamestate.switch(_state_WorldGen)
    end        

    if settings_btn and settings_btn.hit then
        Gamestate.switch(_state_Settings)
    end

    if quit_btn and quit_btn.hit then
        love.event.quit()
    end

end

return GUI

