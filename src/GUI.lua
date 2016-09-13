local GUI = {}

------------------------------------------------
-- State Definition: GUI
------------------------------------------------


function GUI:init()
    -- updating the theme colors
    UI.theme.color.normal.fg = {255,255,255}
    UI.theme.color.hovered = {bg = {150,150,150}, fg = {0,0,0}}
    UI.theme.color.active = {bg = {250,250,250}, fg = {0,0,0}}
end

return GUI