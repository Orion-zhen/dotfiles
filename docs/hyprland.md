# Hyprland

## 效果预览

## 开始使用

想要使用我的配置文件, 只需将`.config`文件夹下的`hypr`, `waybar`, `kitty`, `mako`, `wofi`文件夹复制到`$HOME/.config`中即可

> 本配置文件仅对2K分辨率的Intel和AMD显示输出设备进行调整. 如果你的屏幕分辨率不是2K, 则可能需要调整字体大小等选项. 如果你使用NVIDIA的显示输出设备, 则可以[fuck NVIDIA](https://wiki.hyprland.org/Nvidia)

由于平台不同, 在复制完配置文件后你可能需要做一些修改来达到理想效果

1. 字体效果
    - `.config/hypr/hyprland.conf`中的`misc{}`项中
    - `.config/hypr/hyprlock.conf`中的`label{}`项中. 可以调整字体大小, 显示位置等
    - `.config/kitty/kitty.conf`中的`font_size`项
    - `.config/mako/config`中的`font`项
2. waybar
    - 在`.config/waybar/config`中的`height`项调整面板高度, 在各个模块中的`icon-size`项设置图标大小
    - 在`.config/waybar/style.css`中的`font-size`项调整面板字体大小
3. hypridle
    - 更改`listener`配置以设置不同的息屏, 锁屏, 电源策略
