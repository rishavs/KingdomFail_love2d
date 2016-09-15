local MapGenerator = {}

------------------------------------------------
-- Modules to be used
------------------------------------------------

------------------------------------------------
-- Declarations
------------------------------------------------

local shared_map_obj = {} -- use this obj to share data between functions. clean it after it is used up

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
    local temp_map_obj = {}
    local grid_width, grid_height = MapGenerator.set_sqr_grid_size(grid_size)
    temp_map_obj = MapGenerator.generate_sqr_grid(grid_width, grid_height, cell_size)
    temp_map_obj = MapGenerator.set_elevation(temp_map_obj, grid_width, grid_height, cell_size)

    return temp_map_obj
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

            local sqr_center_x = (sqr_p1_x + sqr_p2_x )/2
            local sqr_center_y = (sqr_p2_y + sqr_p3_y )/2

            local sqr_id = w+1 .. "w" .. h+1 .. "h"
            local sqr_obj = {
                id = sqr_id,
                id_w = w + 1,
                id_h = h + 1,
                center = {x = sqr_center_x, y = sqr_center_y},
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
    print(cX, cY, grid_width, grid_height)
    if 0 < cX  and cX < grid_width and 0 < cY and cY < grid_height then
        return cX, cY
    else
        return false
    end
end

function MapGenerator.set_elevation (map_elv_obj, grid_width, grid_height, cell_size)

    local var_a = 0.1
    local var_b = 1
    local var_c = 1
    local var_d = 0.3
    local var_e = 0.4

    local min_raw_elv = 1
    local max_raw_elv = 0
    local min_raw_mst = 1
    local max_raw_mst = 0

    local grid_pxl_width = grid_width * cell_size
    local grid_pxl_height = grid_height * cell_size

    for id, sqr in pairs(map_elv_obj) do
        if sqr.id_w == 1 or sqr.id_h == 1 or sqr.id_w == grid_width or sqr.id_h == grid_height then
            sqr.elevation = 0
        else
            local dx = 2 * sqr.center.x / grid_pxl_width - 1
            local dy = 2 * sqr.center.y / grid_pxl_height - 1

            local d_sqr =  dx*dx + dy*dy

            local elv_merged_noise =
                  1.00 * love.math.noise (  1 * (dx + seed),   1 * (dy + seed))
                + 0.50 * love.math.noise (  2 * (dx + seed),   2 * (dy + seed))
                + 0.25 * love.math.noise (  4 * (dx + seed),   4 * (dy + seed))
                + 0.13 * love.math.noise (  8 * (dx + seed),   8 * (dy + seed))
                + 0.06 * love.math.noise ( 16 * (dx + seed),  16 * (dy + seed))
                + 0.03 * love.math.noise ( 32 * (dx + seed),  32 * (dy + seed))
                + 0.02 * love.math.noise ( 64 * (dx + seed),  64 * (dy + seed))
                + 0.01 * love.math.noise (128 * (dx + seed), 128 * (dy + seed))

            local elevation = Utils.round(((elv_merged_noise + var_a) * (1 - (var_b*d_sqr^var_c))), 2)

            local water_lvl = Utils.round((var_d + var_e * d_sqr ) , 2)

            if elevation < water_lvl then
                sqr.elevation = 0.0 -- here we can set elevation as ranom between 0 and water lvl when biomes is done
                sqr.biome = "ocean"
            elseif elevation < water_lvl * 1.3 then
                sqr.elevation = 0.1
                sqr.biome = "shallows"
            elseif elevation < water_lvl * 1.4 then
                sqr.elevation = 0.2
                sqr.biome = "coast"
            else
                sqr.elevation = elevation
            end

            -- just debug info to find the lowest elevation
            if elevation < min_raw_elv then
                min_raw_elv = elevation
            end
            -- just debug info to find the highest elevation
            if elevation > max_raw_elv then
                max_raw_elv = elevation
            end

        end

        -- temp gradient value. will be removed when biomes are done
        sqr.lum = math.min(Utils.round(sqr.elevation * 255 ), 255)

    end

    print("Min Elv = " .. min_raw_elv)
    print("Max Elv = " .. max_raw_elv)

    return map_elv_obj
end

return MapGenerator
