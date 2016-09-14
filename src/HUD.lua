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
    love.graphics.setColor(255, 255, 255)
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), scrWidth -150, 30)
end

function HUD:update(dt)

end

return HUD
