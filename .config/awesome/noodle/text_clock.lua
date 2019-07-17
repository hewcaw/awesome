local awful = require("awful")
local wibox = require("wibox")

local my_textclock = wibox.widget.textclock("%H:%M") -- "%l:%M %p")
my_textclock.font = "FuraCode NF Bold 12"
my_textclock.align = "center"
my_textclock.valign = "center"
my_textclock.opacity = 1

return my_textclock
