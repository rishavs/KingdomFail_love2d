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
    -- set neighbour info for each cell
    temp_map_obj = MapGenerator.set_neighbours(temp_map_obj)
    -- set the evevation and moisture
    temp_map_obj = MapGenerator.set_elevation_and_moisture(temp_map_obj, grid_width, grid_height, cell_size)
    -- set up the basic biomes
    temp_map_obj = MapGenerator.set_biomes(temp_map_obj, grid_width, grid_height, cell_size)
    -- setup rivers
    temp_map_obj = MapGenerator.generate_rivers(temp_map_obj)

    return temp_map_obj
end

function MapGenerator.generate_seed(s)
    love.math.setRandomSeed(os.time())
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

    local var_a = 0.5
    local var_b = 0.4
    local var_c = 1
    local var_d = 2


    local min_calc_elv = Utils.round(((0 + var_a) * (1 - (var_b * 2 ^ var_c))), 2)
    local max_calc_elv = Utils.round(((1 + var_a) * (1 - (var_b * (-1) ^ var_c))), 2)
    print('Min elv = ' .. min_calc_elv)
    print('Max elv = ' .. max_calc_elv)

    -- will have to create the moisture seed as a function of the global seed
    love.math.setRandomSeed(seed)
    local mst_seed = love.math.random(1000, 9999)

    local grid_pxl_width = grid_width * cell_size
    local grid_pxl_height = grid_height * cell_size

    for id, sqr in pairs(map_elv_n_mst_obj) do

        local dx = 2 * sqr.center.x / grid_pxl_width - 1
        local dy = 2 * sqr.center.y / grid_pxl_height - 1
        local d_sqr =  dx*dx + dy*dy
        local m_dist = math.max(math.abs(dx), math.abs(dy))

        local elv_merged_noise =
              1.00 * love.math.noise (  1 * (dx + seed),   1 * (dy + seed))
            + 0.50 * love.math.noise (  2 * (dx + seed),   2 * (dy + seed))
            + 0.25 * love.math.noise (  4 * (dx + seed),   4 * (dy + seed))
            + 0.13 * love.math.noise (  8 * (dx + seed),   8 * (dy + seed))
            + 0.06 * love.math.noise ( 16 * (dx + seed),  16 * (dy + seed))
            + 0.03 * love.math.noise ( 32 * (dx + seed),  32 * (dy + seed))
            + 0.02 * love.math.noise ( 64 * (dx + seed),  64 * (dy + seed))
            + 0.01 * love.math.noise (128 * (dx + seed), 128 * (dy + seed))

        elv_merged_noise = (elv_merged_noise ^ var_d)/2

        local elevation = ((elv_merged_noise + var_a) * (1 - (var_b * m_dist^var_c)))

        sqr.elevation = Utils.round(Utils.normalize(elevation, min_calc_elv, max_calc_elv), 2)

        -- print(sqr.elevation)
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
    local var_e = 0.05
    local var_f = 0.4

    local grid_pxl_width = grid_width * cell_size
    local grid_pxl_height = grid_height * cell_size

    for id, sqr in pairs(map_biome_obj) do

        local dx = 2 * sqr.center.x / grid_pxl_width - 1
        local dy = 2 * sqr.center.y / grid_pxl_height - 1
        local d_sqr =  dx*dx + dy*dy

        local sea_lvl =var_e + var_f * d_sqr

        if sqr.elevation < sea_lvl then
            sqr.elevation = 0
            sqr.geoType = 'ocean'
            sqr.fillType = 'line'
        elseif sqr.elevation < sea_lvl * 1.5 then
            sqr.elevation = 0
            sqr.geoType = 'shallows'
            sqr.fillType = 'line'
        else
            sqr.geoType = 'land'
            sqr.fillType = 'fill'
        end

        -- lets set up a temp color for rendering. The color will be defined in HSV space
        -- with elevation dictating the V and moisture dictating the H. Later will be converted to rgb for rendering.

        -- Hue range is 30' to 120'
        local hue = 30 + 90 * sqr.moisture
        -- local hue = 30
        local sat = 100
        local brt = 30 + 200 * sqr.elevation ^ 2 -- no logic here. just trial and error to get a formula which looks good

        sqr.color = Utils.HSVtoRGB(hue, sat, brt)

    end


    return map_biome_obj
end

function MapGenerator.set_neighbours(grid_obj)
    for id, sqr in pairs(grid_obj) do
        local sqr_nbr = {}
        local diag_nbr = {}

        local w = sqr.id_w
        local h = sqr.id_h

        local snb1, snb2, snb3, snb4
        snb1 = w ..'w' .. (h-1) .. 'h'
        snb2 = (w+1) ..'w' .. h .. 'h'
        snb3 = w ..'w' .. (h+1) .. 'h'
        snb4 = (w-1) ..'w' .. h .. 'h'

        if grid_obj[snb1] then
            table.insert(sqr_nbr, snb1)
        end
        if grid_obj[snb2] then
            table.insert(sqr_nbr, snb2)
        end
        if grid_obj[snb3] then
            table.insert(sqr_nbr, snb3)
        end
        if grid_obj[snb4] then
            table.insert(sqr_nbr, snb4)
        end

        local dnb1, dnb2, dnb3, dnb4
        dnb1 = (w+1) ..'w' .. (h-1) .. 'h'
        dnb2 = (w+1) ..'w' .. (h+1) .. 'h'
        dnb3 = (w-1) ..'w' .. (h+1) .. 'h'
        dnb4 = (w-1) ..'w' .. (h-1) .. 'h'

        if grid_obj[dnb1] then
            table.insert(diag_nbr, dnb1)
        end
        if grid_obj[dnb2] then
            table.insert(diag_nbr, dnb2)
        end
        if grid_obj[dnb3] then
            table.insert(diag_nbr, dnb3)
        end
        if grid_obj[dnb4] then
            table.insert(diag_nbr, dnb4)
        end

        sqr.sqr_nbr = sqr_nbr
        sqr.diag_nbr = diag_nbr
    end

    return grid_obj
end

function MapGenerator.get_grid_neighbours(id, grid_obj)
    local neighbours = {}
    neighbours.sqr_nbr = {}
    neighbours.diag_nbr = {}
    neighbours.elv_mst_data_nbr = {}

    local w = grid_obj[id].id_w
    local h = grid_obj[id].id_h

    local snb1, snb2, snb3, snb4
    snb1 = w ..'w' .. (h-1) .. 'h'
    snb2 = (w+1) ..'w' .. h .. 'h'
    snb3 = w ..'w' .. (h+1) .. 'h'
    snb4 = (w-1) ..'w' .. h .. 'h'

    if grid_obj[snb1] then
        table.insert(neighbours.sqr_nbr, snb1)
    end
    if grid_obj[snb2] then
        table.insert(neighbours.sqr_nbr, snb2)
    end
    if grid_obj[snb3] then
        table.insert(neighbours.sqr_nbr, snb3)
    end
    if grid_obj[snb4] then
        table.insert(neighbours.sqr_nbr, snb4)
    end

    local dnb1, dnb2, dnb3, dnb4
    dnb1 = (w+1) ..'w' .. (h-1) .. 'h'
    dnb2 = (w+1) ..'w' .. (h+1) .. 'h'
    dnb3 = (w-1) ..'w' .. (h+1) .. 'h'
    dnb4 = (w-1) ..'w' .. (h-1) .. 'h'

    if grid_obj[dnb1] then
        table.insert(neighbours.diag_nbr, dnb1)
    end
    if grid_obj[dnb2] then
        table.insert(neighbours.diag_nbr, dnb2)
    end
    if grid_obj[dnb3] then
        table.insert(neighbours.diag_nbr, dnb3)
    end
    if grid_obj[dnb4] then
        table.insert(neighbours.diag_nbr, dnb4)
    end

    return neighbours
end

function MapGenerator.generate_rivers(grid_rvr_obj)

    -- parameter governing rivers
    local origin, meander_val, broaden_val, volume_val
    --for the sake of testing, find the highest point in the grid
    local highest_cell
    local highest_elv = 0.7

    for id, sqr in pairs(grid_rvr_obj) do
        -- just skip anyting less than .7
        if sqr.elevation > highest_elv then
            highest_cell = id
            highest_elv = sqr.elevation
        end

    end
    print("Highest Point = " .. highest_cell)
    print("Highest Elv = " .. highest_elv)

    local cur_id = highest_cell
    local cur_elv = highest_elv
    local nxt_id
    local nxt_elv

    -- run loop till river reaches the coast
    while grid_rvr_obj[cur_id].geoType ~= 'shallows' do

        grid_rvr_obj[cur_id].geoType = 'shallows'

        -- get the neighbours of the current cell
        local nbr = grid_rvr_obj[cur_id].sqr_nbr

        local lowest_elv = grid_rvr_obj[cur_id].elevation

        -- find the lowest elevation cell which is the neighbour to teh current cell
        for i, id in ipairs(nbr) do
            if grid_rvr_obj[id].elevation < lowest_elv then
                lowest_cell = id
                lowest_elv = grid_rvr_obj[id].elevation
            end
        end

        -- If the evevation of the lowest neighbour is lower than the current cells elevation
        -- then set this neighbour as the next cell to be turned to river
        if lowest_elv < grid_rvr_obj[cur_id].elevation then
            cur_id = lowest_cell
        else
            -- in case where the next cell elevation is not smaller than current cell, we cant rely on gravity to
            -- define the water flow. in such cases, we will take the farthest cell from the starting point as the next cell.

            -- find the furthest cell from current cell
            local furthest_dist = 0
            local furthest_cell
            for i, id in ipairs(nbr) do
                local nbr_dist = math.sqrt(
                      (grid_rvr_obj[highest_cell].id_w - grid_rvr_obj[id].id_w)^2
                    + (grid_rvr_obj[highest_cell].id_h - grid_rvr_obj[id].id_h)^2
                )
                if nbr_dist > furthest_dist then
                    furthest_dist = nbr_dist
                    furthest_cell = id
                end
            end
            lowest_cell = furthest_cell
            cur_id = lowest_cell
            print("lode lag gaye.")
        end
    end

    return grid_rvr_obj
end

return MapGenerator
