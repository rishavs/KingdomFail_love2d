local _state_WorldGen = {}

------------------------------------------------
-- Modules to be used
------------------------------------------------

GUI = require "src.GUI"
HUD = require "src.HUD"
Utils = require "src.Utils"
Map = require "src.MapGenerator"

------------------------------------------------
-- Declarations
------------------------------------------------
seed = Map.generate_seed(s)
cell_size = 4
grid_size = "M"

map_obj = {}

------------------------------------------------
-- State Definition: _state_WorldGen
------------------------------------------------
function _state_WorldGen:init()
    map_obj = Map.generate_map(seed, grid_size, cell_size)
    GUI:init()
    HUD:init()
end

function _state_WorldGen:draw()
    love.graphics.setColor(50, 50, 50)

    for id, sqr in pairs(map_obj) do
        -- love.graphics.points(sqr.center.x, sqr.center.y)
        love.graphics.setColor(sqr.lum, sqr.lum, sqr.lum)
        love.graphics.rectangle('fill', sqr.vertices[1], sqr.vertices[2], cell_size, cell_size)
    end

    GUI:draw()
    HUD:draw()
end

function _state_WorldGen:update(dt)
    GUI:update()
    HUD:update(dt)
end

function _state_WorldGen:mousepressed(x, y, button)
    if button == 1 then
        print("Mouse clicked at : ".. x .. ", " .. y)
        local g_width, g_height = Map.set_sqr_grid_size(grid_size)
        print(Map.get_sqr_grid_coords_from_world_coords(x, y, g_width, g_height, cell_size))
        -- print(Inspect(map_obj))
    elseif button == 2 then
        print()

    end
end

function _state_WorldGen:keyreleased(key)
    if key == 'return' then
        Gamestate.switch(_state_MainMenu)
    elseif key == 'space' then
        map_obj = Map.generate_map(seed, grid_size, cell_size)
    end
end

------------------------------------------------
-- State functions: _state_WorldGen
------------------------------------------------

function draw_map_to_canvas()

end

return _state_WorldGen
