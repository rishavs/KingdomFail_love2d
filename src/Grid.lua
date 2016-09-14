local Grid = {}

------------------------------------------------
-- Declarations
------------------------------------------------

local grid_width
local grid_height

local grid_S_width = 80
local grid_S_height = 60

local grid_M_width = 200
local grid_M_height = 150

local grid_L_width = 400
local grid_L_height = 300

if grid_size == "S" then
    grid_width = grid_S_width
    grid_height = grid_S_height
end
------------------------------------------------
-- Module Callbacks: Grid
------------------------------------------------

function Grid:init()

end

function Grid:draw()

end

function Grid:update(dt)

end

------------------------------------------------
-- Module Methods: Grid
------------------------------------------------

function Grid.set_sqr_grid_size(grid_size)

end

function Grid.generate_sqr_grid(grid_size, cell_size)

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

            grid_obj[sqr_id] = sqr_obj
        end
    end

    return grid_obj
end

function Grid.get_sqr_grid_coords_from_world_coords(mx, my, grid_size, cell_size)

end

function Grid.draw_sqr_grid_to_canvas()

    return canvas
end

return Grid
