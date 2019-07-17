---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
--local themes_path = gfs.get_themes_dir()


local themes_path = os.getenv("HOME") .. "/.config/awesome/themes/"
-- =====================================================
local layout_path = themes_path .. "/widget/layout/"
local taglist_path = themes_path .. "/widget/taglist/"
local battery_path = themes_path .. "/widget/battery/"
local net_path = themes_path .. "/widget/net/"
local volume_path = themes_path .. "/widget/volume/"

local xrdb = xresources.get_current_theme()
-- =====================================================


local theme = {}

-- Wallpaper
theme.wallpaper = themes_path .. "/wall.png"

theme.font          = "monospace 8"

-- Get colors from .Xresources
theme.xbackground = xrdb.background
theme.xforeground = xrdb.foreground
theme.xcolor0     = xrdb.color0
theme.xcolor1     = xrdb.color1
theme.xcolor2     = xrdb.color2
theme.xcolor3     = xrdb.color3
theme.xcolor4     = xrdb.color4
theme.xcolor5     = xrdb.color5
theme.xcolor6     = xrdb.color6
theme.xcolor7     = xrdb.color7
theme.xcolor8     = xrdb.color8
theme.xcolor9     = xrdb.color9
theme.xcolor10    = xrdb.color10
theme.xcolor11    = xrdb.color11
theme.xcolor12    = xrdb.color12
theme.xcolor13    = xrdb.color13
theme.xcolor14    = xrdb.color14
theme.xcolor15    = xrdb.color15


theme.bg_normal     = "#222222"
theme.bg_focus      = "#535d6c"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.useless_gap   = dpi(3)
theme.border_width  = dpi(0)
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"


-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- #### MENU ####
--theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)



-- #### LAYOUT ####
-- You can use your own layout icons like this:
theme.layout_tileleft = layout_path .. "tileleft.png"
theme.layout_max = layout_path .. "max.png"
theme.layout_floating = layout_path .. "floating.png"



-- {{{  WIBAR  ---------------------------------------
theme.wibar_position = "top"
theme.wibar_height = dpi(40)
--theme.wibar_width = dpi()
theme.wibar_bg = theme.xcolor0 .. "00"


--  Widget separator
theme.separator_text = "|"
theme.separator_fg = theme.xcolor8

--  Tags names
theme.tagnames = {
    "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"
}

--  Icon taglist
local ntags = 10
theme.taglist_icons_empty = {}
theme.taglist_icons_occupied = {}
theme.taglist_icons_focused = {}
theme.taglist_icons_urgent = {}
-- table.insert(tag_icons, tag)
for i = 1, ntags do
  theme.taglist_icons_empty[i]    = taglist_path .. tostring(i) .. "_empty.png"
  theme.taglist_icons_occupied[i] = taglist_path .. tostring(i) .. "_occupied.png"
  theme.taglist_icons_focused[i]  = taglist_path .. tostring(i) .. "_focused.png"
  theme.taglist_icons_urgent[i]   = taglist_path .. tostring(i) .. "_urgent.png"
end

-- Battery icon 
theme.battery_icon_warning      = battery_path .. "nichosi.png"
theme.battery_icons_charging = {}
theme.battery_icons = {}
for i = 1, ntags do
    theme.battery_icons_charging[i] = battery_path .. "c" .. tostring(i) .. ".png"
    theme.battery_icons[i]          = battery_path .. tostring(i) .. ".png"
end

-- Net icon
--          // Ethernet 
theme.wired_icon        = net_path .. "wired.png"
theme.wired_icon_na     = net_path .. "wired_na.png"
--          // Wireless 
theme.wl_icon_excellent     = net_path .. "wl_high.png"
theme.wl_icon_good          = net_path .. "wl_medium.png"
theme.wl_icon_unstable      = net_path .. "wl_low.png"
theme.wl_icon_na            = net_path .. "wl_na.png"

-- Volume icon 
theme.vol_icon_0 = volume_path .. "na.png"
theme.vol_icon_1 = volume_path .. "low.png"
theme.vol_icon_2 = volume_path .. "medium.png"
theme.vol_icon_3 = volume_path .. "high.png"
theme.vol_icon_4 = volume_path .. "highest.png"
-- }}}-------------------------------------------------- 

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
