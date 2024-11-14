# dotfiles

想要快速开始使用, 可以使用仓库中提供的一键安装脚本. 目前仅在Arch Linux上测试过. `archinstall-config.json` 适用于使用 `archinstall` 命令时的快速加载配置文件:

```shell
archinstall --config /path/to/archinstall-config.json
```

加载这个配置后, 仅需手动指定磁盘分区和用户配置即可.

```shell
# On github
git clone https://github.com/Orion-zhen/dotfiles.git
# On gitee
git clone https://gitee.com/Orion-zhen/dotfiles.git

cd dotfiles
bash install.sh help # 查看用法
```

这个脚本将会安装一些常用软件和hyprland, 并复制本仓库的配置文件到系统中
