-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")
-- Themes define colours, icons, font and wallpapers.
beautiful.init( os.getenv("HOME") .. "/.config/awesome/themes/theme.lua")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

--local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")


-- ===================================================
local keys = require("keys")
local helpers = require("helpers")

local bars = require("bars")
--local volume_popup = require("noodle.volume_popup")
-- ===================================================



-- {{{ Variable definitions
--beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "xterm"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor


-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile.left,
    awful.layout.suit.max,
    awful.layout.suit.floating,
}
-- }}}




-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}




-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()




-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    --s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create the wibox
    --s.mywibox = awful.wibar({ position = "top", screen = s, width = beautiful.wibar_width })

    ----s.mywibox = wibox({ x=900, screen=s, y=1000, width= })
    ---- Add widgets to the wibox
    --s.mywibox:setup {
    --    layout = wibox.layout.align.horizontal,
    --    --{ -- Left widgets
    --    --    layout = wibox.layout.fixed.horizontal,
    --    --    --mylauncher,
    --    --    --s.mytaglist,
    --    --    --s.mypromptbox,
    --    --},
    --    {
    --        layout = wibox.layout.align.horizontal,
    --        icon_taglist,
    --    },
    --    --s.mytasklist, -- Middle widget
    --    { -- Right widgets
    --        layout = wibox.layout.flex.horizontal,
    --        --mykeyboardlayout,
    --        --wibox.widget.systray(),
    --        --mytextclock,
    --        s.mylayoutbox,
    --    },
    --}
end)
-- }}}


-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     size_hints_honor = false,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    }
}


-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)


-- Rounded corners
if beautiful.border_radius ~= 0 then
    client.connect_signal("manage", function(c)  -- why function(c, startup)
        if not c.fullscreen then
            c.shape = helpers.rrect(beautiful.border_radius)
        end
    end)

    --[[
    -- Fullscreen & maximised clients should not have rounded corners
    local function no_round_corners (c)
        if c.fullscreen or c.maximized then
            c.shape = helpers.rect()
        else
            c.shape = helpers.rrect(beautiful.border_radius)
        end
    end
    --]]
end


-- Startup 
awful.spawn.with_shell( os.getenv("HOME") .. "/.config/awesome/autostart.sh")
-- }}}
