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

    -- TODO: merge all seprate functions in a single for loop
    -- Generate the grid
    temp_map_obj = MapGenerator.generate_sqr_grid(grid_width, grid_height, cell_size)
    -- set the evevation and moisture
    temp_map_obj = MapGenerator.set_elevation_and_moisture(temp_map_obj, grid_width, grid_height, cell_size)
    -- set up the basic biomes
    temp_map_obj = MapGenerator.set_biomes(temp_map_obj, grid_width, grid_height, cell_size)

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

    if 0 < cX  and cX < grid_width and 0 < cY and cY < grid_height then
        return {w = cX, h = cY}
    else
        return false
    end
end

function MapGenerator.set_elevation_and_moisture (map_elv_n_mst_obj, grid_width, grid_height, cell_size)

    local var_a = 0.2
    local var_b = 0.9
    local var_c = 1

    local min_calc_elv = Utils.round(((0 + var_a) * (1 - (var_b * 2 ^ var_c))), 2)
    local max_calc_elv = Utils.round(((1 + var_a) * (1 - (var_b * 0 ^ var_c))), 2)

    -- will have to create the moisture seed as a function of the global seed
    love.math.setRandomSeed(seed)
    local mst_seed = love.math.random(1000, 9999)

    local grid_pxl_width = grid_width * cell_size
    local grid_pxl_height = grid_height * cell_size

    for id, sqr in pairs(map_elv_n_mst_obj) do

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

        local elevation = ((elv_merged_noise/2 + var_a) * (1 - (var_b * d_sqr^var_c)))
        sqr.elevation = Utils.round(Utils.normalize(elevation, min_calc_elv, max_calc_elv), 2)

        local mst_merged_noise =
              1.00 * love.math.noise (  1 * (dx + mst_seed),   1 * (dy + mst_seed))
            + 0.50 * love.math.noise (  2 * (dx + mst_seed),   2 * (dy + mst_seed))
            + 0.25 * love.math.noise (  4 * (dx + mst_seed),   4 * (dy + mst_seed))
            + 0.13 * love.math.noise (  8 * (dx + mst_seed),   8 * (dy + mst_seed))
            + 0.06 * love.math.noise ( 16 * (dx + mst_seed),  16 * (dy + mst_seed))
            + 0.03 * love.math.noise ( 32 * (dx + mst_seed),  32 * (dy + mst_seed))
            + 0.02 * love.math.noise ( 64 * (dx + mst_seed),  64 * (dy + mst_seed))
            + 0.01 * love.math.noise (128 * (dx + mst_seed), 128 * (dy + mst_seed))

        local moisture = Utils.round(mst_merged_noise/2, 2)
        sqr.moisture = moisture

    end

    return map_elv_n_mst_obj
end

function MapGenerator.set_biomes(map_biome_obj, grid_width, grid_height, cell_size)

    local var_d = 0.25
    local var_e = 0.1

    for id, sqr in pairs(map_biome_obj) do
        if sqr.id_w == 1 or sqr.id_h == 1 or sqr.id_w == grid_width or sqr.id_h == grid_height then
            sqr.biome = 'ocean'
            sqr.cell_is_on_edge = true
            sqr.lum = 0
        else

            local grid_pxl_width = grid_width * cell_size
            local grid_pxl_height = grid_height * cell_size

            local dx = 2 * sqr.center.x / grid_pxl_width - 1
            local dy = 2 * sqr.center.y / grid_pxl_height - 1
            local d_sqr =  dx*dx + dy*dy

            local water_lvl = Utils.round((var_d + var_e * d_sqr ) , 2)

            if sqr.elevation < water_lvl then
                sqr.lum = 0 -- here we can set elevation as ranom between 0 and water lvl when biomes is done
                sqr.biome = "ocean"
            elseif sqr.elevation < water_lvl * 1.3 then
                sqr.lum = math.min(Utils.round(0.1 * 255 ), 255)
                sqr.biome = "shallows"
            elseif sqr.elevation < water_lvl * 1.35 then
                sqr.lum = math.min(Utils.round(0.2 * 255 ), 255)
                sqr.biome = "coast"
            else
                sqr.biome = 'land'
                -- temp gradient value. will be removed when biomes are done
                sqr.lum = math.min(Utils.round(sqr.elevation * 255 ), 255)
            end

        end
    end


    return map_biome_obj
end

return MapGenerator
