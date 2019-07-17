local gears = require("gears")






local helpers = {}

-- Create rounded rectangle shape
helpers.rrect = function(radius)
    return function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, radius)
    end
end

--[[
helpers.rect = function()
    return function(cr, width, height)
        gears.shape.rectangle(cr, width, height)
    end
end
--]]

return helpers
