local HUD = {}

------------------------------------------------
-- Declarations
------------------------------------------------

------------------------------------------------
-- Module Definition: HUD
------------------------------------------------

function HUD:init()

end

function HUD:draw()

    love.graphics.setColor(0, 0, 0)
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), scrWidth -150, 30)
    -- love.graphics.print("Total Land Area: "..tostring(landArea) .. ' sqr units', scrWidth -150, 30)
    -- love.graphics.print("Total Ocean Area: "..tostring(landArea) .. ' sqr units', scrWidth -150, 30)
end

function HUD:update(dt)

end

return HUD
