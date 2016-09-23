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

river_origin = {}

local stime, ttime
local landArea = 0

------------------------------------------------
-- State Definition: _state_WorldGen
------------------------------------------------
function _state_WorldGen:init()
    stime = love.timer.getTime()
    -- contents, size = love.filesystem.read( 'data/biomes.json')

    -- data = json.decode(contents)
    -- print(Inspect(data))

    map_obj.grid = Map.generate_map(seed, grid_size, cell_size)
    GUI:init()
    HUD:init()

    ttime = (love.timer.getTime() - stime)
end

function _state_WorldGen:draw()

    for id, sqr in pairs(map_obj.grid) do
        if sqr.geoType == 'land' then
            love.graphics.setColor(sqr.color.r, sqr.color.g, sqr.color.b)
        elseif sqr.geoType == 'mountains' then
            love.graphics.setColor(200, 200, 200)
        elseif sqr.geoType == 'coast' then
            love.graphics.setColor(220, 190, 140)
        elseif sqr.geoType == 'freshwater' then
            love.graphics.setColor(0, 130, 150)
        elseif sqr.geoType == 'shallows' then
            love.graphics.setColor(130, 210, 230)
        elseif sqr.geoType == 'ocean' then
            love.graphics.setColor(0, 130, 150)
        end
        love.graphics.rectangle(sqr.fillType, sqr.vertices[1], sqr.vertices[2], cell_size, cell_size)
        -- if sqr.elevation <= 0.3 then
        --     love.graphics.setColor(200, 0, 0)
        --     love.graphics.rectangle(sqr.fillType, sqr.vertices[1], sqr.vertices[2], cell_size, cell_size)
        -- end
    end

    love.graphics.setColor(0, 0, 0)
    love.graphics.print("Time taken : "..tostring(Utils.round(ttime, 1)) .. " seconds", 10, 70)

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
        local g_coords = Map.get_sqr_grid_coords_from_world_coords(x, y, g_width, g_height, cell_size)
        if g_coords then
            print('Grid coords = ' .. g_coords.w .. ", " .. g_coords.h)
            print('Cell Details :')
            local gid = g_coords.w .. "w" .. g_coords.h .. "h"
            print(Inspect(map_obj.grid[gid]))
            -- print(Inspect(map_obj))
            local nbr = map_obj.grid[gid].sqr_nbr
            for _, nhr in pairs(nbr) do
                map_obj.grid[nhr].fillType = 'line'
            end
        end
        map_obj.grid[g_coords.w .. "w" .. g_coords.h .. "h"].fillType = "line"
    elseif button == 2 then


    end
end

function _state_WorldGen:keyreleased(key)
    if key == 'return' then
        Gamestate.switch(_state_MainMenu)
    elseif key == 'space' then
        seed = Map.generate_seed()
        map_obj.grid = Map.generate_map(seed, grid_size, cell_size)
    end
end

------------------------------------------------
-- State functions: _state_WorldGen
------------------------------------------------

function draw_map_to_canvas()

end

return _state_WorldGen
