local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")


local net_widget = wibox.widget {
    widget = wibox.widget.imagebox
}


local update_interval = 5
local net_script = [[
    bash -c "
        ip a | grep LOWER_UP | grep -v '1: lo' | head -n 1 | awk '{print $2}' | cut -d ':' -f 1
"]]


awful.widget.watch(net_script, update_interval, function(widget, stdout)
    local net_img

    local interface = stdout:match("%a%a")
    -- local has_net = io.popen("ip route show | grep " .. stdout .. " | tail -n 1 | awk '{print $9}'") -- XXX: BUGS at grep .. stdout
    local has_net = io.popen("ip route show")
    has_net = has_net:read('*a')

    if interface == "en" then
        if has_net ~= '' then
            net_img = beautiful.wired_icon
        else
            net_img = beautiful.wired_icon_na
        end
    else
    end

    net_widget.image = net_img
end)

return net_widget
