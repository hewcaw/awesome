local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
--local watch = require("awful.widget.watch")
local beautiful = require("beautiful")


local helpers = require("helpers")

-- -------------------------------------------------------------

local battery = wibox.widget { 
    widget = wibox.widget.imagebox,
    forced_height = 30,
    forced_width = 32,
}

local bat_text = wibox.widget {
    font = 'FuraCode NF Medium 12',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox,
}

local battery_widget = wibox.widget {
    battery, 
    bat_text,
    layout = wibox.layout.fixed.horizontal,
}


local function show_battery_warning()
    naughty.notify{
        icon = beautiful.battery_icon_warning,
        icon_size=90,
        text = "<b>BATTERY IS DYING</b>",
        title = "Huston, we have a problem\n",
        timeout = 7,
        position = "top_right",
        bg = "#f06060",
        fg = "#eee9ef",
        shape = helpers.rrect(9),       -- round corner
        width = 300,
    }
end


local update_interval = 30
local bat_script = [[
    bash -c "
    acpi | awk '{print $3 $4 $5}' | awk -F, '{print $1, $2, $3}'  
    "]] 

awful.widget.watch(bat_script, update_interval, function(widget, stdout)

    local bat_img
    -- eg: Discharging, 80%, 70:70:00 :)   (Through the bash script above)
    local status, percentage, time = stdout:match("(%S+)%s+(%S+)%s*(%S*)")
    local per_num = tonumber(percentage:match("%d*%d*%d"))

    if status ~= nil then

        -- If percentage is lower than 20, call WARNING
        if (per_num <= 13 and status ~= 'Charging') then
            show_battery_warning()
        end

        local min = 0
        local max = 10

        for i = 1, 10 do 
            if (per_num > min and per_num <= max) then
               if status ~= 'Charging' then 
                   bat_img = beautiful.battery_icons[i]
               else 
                   bat_img = beautiful.battery_icons_charging[i]
               end
            end
            min = max
            max = max + 10
        end
    end
    -- for s in stdout:gmatch("[^\n]+") do
    --     status, percentage, time = s:match("(%S+)%s+(%S)%s*(%S*)")
    -- end
    battery.image = bat_img
    bat_text.markup = ' ' .. percentage
end)

return battery_widget
