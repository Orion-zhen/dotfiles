# Waydroid

安装waydroid需要`binder`模块, 可以安装`binder_linux-dkms`<sup>archlinuxcn</sup>或`binder_linux-dkms`<sup>AUR<sup>

想要完全卸载waydroid, 则:

```shell
sudo waydroid session stop
sudo waydroid container stop
yay -Rnsc waydroid
sudo rm -rf /var/lib/waydroid /home/.waydroid ~/.waydroid ~/.share/waydroid ~/.local/share/applications/*aydroid* ~/.local/share/waydroid
```
