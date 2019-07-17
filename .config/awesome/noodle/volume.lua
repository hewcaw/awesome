local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local naughty = require("naughty")



--mute_color = "#ff0000"
--bar_color = "#5aa3cc"
--background_color = "#222222"

local GET_VOLUME = "amixer sget Master | tail -n 2"
--local INC_VOLUME = 'amixer sset Master 5%+'
--local DEC_VOLUME = 'amixer sset Master 5%-'
--local TOG_VOLUME = 'amixer sset Master toggle'

local volume_widget = wibox.widget {
    widget = wibox.widget.imagebox,
    forced_height = 32,
    forced_width = 32,
}

--local volumebar_widget = wibox.widget {
--    max_value = 1,
--    forced_width = 100,
--    forced_height = 50,
--    paddings = 0,
--    border_width = 0.5,
--    color = "#5aa3cc",
--    background_color = "#222222",
--    clip = true,
--    margins = {
--        top = dpi(8),
--        bottom = dpi(10),
--    },
--    widget = wibox.widget.progressbar
--}

local vol_img 
local function update_widget()
    awful.spawn.easy_async_with_shell(GET_VOLUME, function(out)

        local mute = string.match(out, "%[(o%D%D?)%]")
        local volume = string.match(out, "%[(%d?%d?%d)")
        volume = tonumber(volume)
        naughty.notify({ text = mute}) 
        
        if mute == "off" then 
            vol_img = beautiful.vol_icon_0
        else
            naughty.notify({ text = tostring(volume) })
            if (volume == 0) then vol_img = beautiful.vol_icon_0
            elseif (volume > 0 and volume <= 25) then vol_img = beautiful.vol_icon_1
            elseif (volume > 25 and volume <= 50) then vol_img = beautiful.vol_icon_2
            elseif (volume > 50 and volume <= 75) then vol_img = beautiful.vol_icon_3
            elseif (volume > 75 and volume <= 100) then vol_img = beautiful.vol_icon_4
            end
        end
        -- volumebar_widget.value = volume / 100;
        -- volumebar_widget.color = mute == "off" and mute_color or bar_color
        volume_widget.image = vol_img
    end)
end


-- Signal
awesome.connect_signal("audio_changed", function() 
    update_widget()
end)

update_widget()

return volume_widget
