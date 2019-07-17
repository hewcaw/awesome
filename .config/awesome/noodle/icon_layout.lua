local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")


awful.screen.connect_for_each_screen(function(s)
    s.mylayoutbox = awful.widget.layoutbox(s)
end)

