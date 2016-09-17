local Utils = {}

function Utils.foo()
	print("Hello World!")
end

-- Clamps a number to within a certain range.
function Utils.clamp(n, low, high)
	return math.min(math.max(low, n), high)
end

function Utils.round(num, dp)
    local mult = 10^(dp or 0)
    return (math.floor(num * mult + 0.5)) / mult
end

-- n% chance of the function returning true
function Utils.probability(n)
    if n == 100 then
        return true
    elseif n == 0 then
        return false
    else
        local rand = math.random(0, 100)

        if rand < n then
            return true
        else
            return false
        end
    end
end

function Utils.HSVtoRGB(h, s, v)

    local color = {}

    if s <= 0 then return v,v,v end

    h, s, v = h/256*6, s/255, v/255
    local c = v*s
    local x = (1-math.abs((h%2)-1))*c
    local m,r,g,b = (v-c), 0,0,0

    if h < 1     then
        r,g,b = c,x,0
    elseif h < 2 then
        r,g,b = x,c,0
    elseif h < 3 then
        r,g,b = 0,c,x
    elseif h < 4 then
        r,g,b = 0,x,c
    elseif h < 5 then
        r,g,b = x,0,c
    else
        r,g,b = c,0,x
    end

    return {r = math.floor((r+m)*255), g = math.floor((g+m)*255), b = math.floor((b+m)*255)}

end

-- normalizes the number between given range and returns the corresponding value between 0 and 1
function Utils.normalize (n, min, max)
    return math.max((n - min) / ( max - min ), 0)
end

return Utils
