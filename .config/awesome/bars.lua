local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi


-- {{{ Widgets
-- local icon_layout = require("noodle.icon_layout")
local text_clock = require("noodle.text_clock")
local icon_taglist = require("noodle.icon_taglist")
local volume = require("noodle.volume")
local net = require("noodle.net")
local battery = require("noodle.battery")
--}}}


awful.screen.connect_for_each_screen(function(s)
    s.mywibox = awful.wibar({ position=beautiful.wibar_position, screen=s })

    s.mywibox:setup {
        {
            layout = wibox.layout.fixed.horizontal,
            text_clock,
        },
        {
            layout = wibox.layout.fixed.horizontal,
            icon_taglist,
            --icon_layout, 
        },
        {
            layout = wibox.layout.fixed.horizontal,
            volume,
            net,
            battery,
        },
        layout = wibox.layout.align.horizontal,
        -- ajust_ratio(2, 0.25, 0.5, 0.25)
    }
end)
