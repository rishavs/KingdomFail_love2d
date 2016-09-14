local MapGenerator = {}


------------------------------------------------
-- Modules to be used
------------------------------------------------

------------------------------------------------
-- Declarations
------------------------------------------------

------------------------------------------------
-- Module Callbacks: MapGenerator
------------------------------------------------

function MapGenerator:init()

end

function MapGenerator:draw()

end

function MapGenerator:update(dt)

end

------------------------------------------------
-- Module Methods: MapGenerator
------------------------------------------------

-- higest level function.
function MapGenerator.generate_map(seed, grid_size, cell_size)
    local fn_map_obj = {}
    local grid_width, grid_height = MapGenerator.set_sqr_grid_size(grid_size)
    fn_map_obj = MapGenerator.generate_sqr_grid(grid_width, grid_height, cell_size)

    return fn_map_obj
end

function MapGenerator.generate_seed(s)
    local seed_min = 1000
    local seed_max = 9999

    if s then
        return s
    else
        -- Seed is a 4 digit number
        return love.math.random(seed_min, seed_max )
        -- print("Seed : " .. seed)
    end
end

function MapGenerator.set_sqr_grid_size(grid_size)
    if grid_size == 'S' then
        return 80, 60
    elseif grid_size == 'M' then
        return 200, 150
    elseif grid_size == 'L' then
        return 400, 300
    end
end

function MapGenerator.generate_sqr_grid(grid_width, grid_height, cell_size)
    local fn_grid_obj = {}
    for h = 0, grid_height-1 do
        for w = 0, grid_width-1 do

            local sqr_p1_x = w * cell_size
            local sqr_p1_y = h * cell_size

            local sqr_p2_x = (w + 1) * cell_size
            local sqr_p2_y = h * cell_size

            local sqr_p3_x = w * cell_size
            local sqr_p3_y = (h + 1) * cell_size

            local sqr_p4_x = (w + 1) * cell_size
            local sqr_p4_y = (h + 1) * cell_size

            local sqr_id = w+1 .. "w" .. h+1 .. "h"
            local sqr_obj = { id = sqr_id,
                vertices = {sqr_p1_x, sqr_p1_y, sqr_p2_x, sqr_p2_y, sqr_p3_x, sqr_p3_y, sqr_p4_x, sqr_p4y }
            }

            fn_grid_obj[sqr_id] = sqr_obj
        end
    end

    return fn_grid_obj
end

function MapGenerator.get_sqr_grid_coords_from_world_coords(mx, my, grid_width, grid_height, cell_size)
    local cX = math.floor(mx/cell_size) + 1
    local cY = math.floor(my/cell_size) + 1
    return cX, cY
end


return MapGenerator
