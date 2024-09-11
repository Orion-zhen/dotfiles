# 杂项

## forgit

[forgit](https://github.com/wfxr/forgit)常用命令:

- `ga` = `git add`
- `gi` = edit `.gitignore`
- `gd` = `git diff`
- `gcb` = `git checkout <branch>`

## fzf

快捷键:

- `Ctrl + T`快捷打开行内搜索文件
- `**`+`Tab`可以触发搜索补全, 补全条目取决于前缀命令, 可以是文件, 目录, ssh远程, 进程名, 环境变量等. 可以配合`cd`, `code`, `ssh`, `kill`, `unset`等
- `Ctrl + R`快捷打开历史命令搜索

使用`fd`<sup>extra</sup>代替`find`, 与`fzf`配合更好

## obs-studio

想要让obs在wayland下工作, 需要安装来`obs-vaapi`, `gstreamer-vaapi`, `wlrobs-hg`

## Waydroid

安装waydroid需要`binder`模块, 可以安装`binder_linux-dkms`<sup>archlinuxcn</sup>或`binder_linux-dkms`<sup>AUR<sup>

想要完全卸载waydroid, 则:

```shell
sudo waydroid session stop
sudo waydroid container stop
yay -Rnsc waydroid
sudo rm -rf /var/lib/waydroid /home/.waydroid ~/.waydroid ~/.share/waydroid ~/.local/share/applications/*aydroid* ~/.local/share/waydroid
```
