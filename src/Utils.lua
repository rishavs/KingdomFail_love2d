local Utils = {}

function Utils.foo()
	print("Hello World!")
end

-- Clamps a number to within a certain range.
function Utils.clamp(low, high, n) 
	return math.min(math.max(low, n), high) 
end

function Utils.round(num, dp)
    local mult = 10^(dp or 0)
    return (math.floor(num * mult + 0.5)) / mult
end

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

return Utils