local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- 配色方案
-- 参考 https://github.com/mbadolato/iTerm2-Color-Schemes#screenshots
config.color_scheme = "Dark+"
config.colors = {}

-- 标签栏配置
config.enable_tab_bar = true
-- 样式
config.use_fancy_tab_bar = true
-- 仅有一个标签页时关闭标签栏
config.hide_tab_bar_if_only_one_tab = false
-- 标签栏置底
config.tab_bar_at_bottom = false
-- 标签栏配色
config.colors.tab_bar = {
    background = "rgba(12%, 12%, 18%, 90%)", -- 整体背景
    -- 活跃标签页
    active_tab = {
        bg_color = "#8fb2c9",
        fg_color = "rgba(12%, 12%, 18%, 0%)",
        intensity = "Bold",
    },
    -- 非活跃标签页
    inactive_tab = {
        fg_color = "#8fb2c9",
        bg_color = "rgba(12%, 12%, 18%, 90%)",
        intensity = "Normal",
    },
    -- 非活跃标签页鼠标悬停
    inactive_tab_hover = {
        fg_color = "#8fb2c9",
        bg_color = "rgba(27%, 28%, 35%, 90%)",
        intensity = "Bold",
    },
    -- 新窗口
    new_tab = {
        fg_color = "#808080",
        bg_color = "#1e1e2e",
    },
}

-- 非活跃窗口变暗
config.inactive_pane_hsb = {
    saturation = 0.9, -- 降低饱和度
    brightness = 0.9, -- 降低亮度
}

-- 终端背景
-- config.window_background_image = "/path/to/my/wallpaper"
-- 背景图片设置
config.window_background_image_hsb = {
    brightness = 0.3, -- 图片亮度
    hue = 1.0,        -- 图片色调, 1.0 为保持不变
    saturation = 1.0, -- 饱和度, 1.0 为保持不变
}

-- 背景不透明度
config.window_background_opacity = 0.8
-- 背景模糊
config.macos_window_background_blur = 32

-- 字体设置
config.font = wezterm.font({ family = "Maple Mono NF", style = "Normal" })
config.font_size = 15.0

-- 窗口栏设置
config.window_decorations = "RESIZE | MACOS_FORCE_ENABLE_SHADOW | INTEGRATED_BUTTONS"
-- RESIZE: 可调整大小
-- TITLE: 启用标题栏
-- NONE: 啥都没有
-- MACOS_FORCE_ENABLE_SHADOW: 启用阴影效果
-- INTEGRATED_BUTTONS: 将窗口管理按钮内嵌到标签栏中

-- 是否使用 macOS 系统级全屏
config.native_macos_fullscreen_mode = true

-- 启用滚动条
config.enable_scroll_bar = false
-- 焦点跟随鼠标
config.pane_focus_follows_mouse = true

-- 鼠标滑动切换标签页
config.mouse_wheel_scrolls_tabs = true

return config
