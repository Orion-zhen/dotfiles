# Networking and Mirrors

## 换源

### reflector

使用`reflector`来更换`pacman`的软件源:

```shell
reflector -c China --verbose --latest 10 --save /etc/pacman.d/mirrorlist
```

### archlinuxcn

有如下镜像源:

```conf
## CERNET (中国) (ipv4, ipv6, http, https)
## Added: 2023-08-19
## This will redirect you to the nearest China educational mirror site. However, please note that some sites may not support IPv6.
[archlinuxcn]
Server = https://mirrors.cernet.edu.cn/archlinuxcn/$arch
```

```conf
## 清华大学 (北京) (ipv4, ipv6, http, https)
[archlinuxcn]
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
```

```conf
## 西安交通大学 (陕西西安) (ipv4, ipv6, http, https)
## Added: 2023-08-19
[archlinuxcn]
Server = https://mirrors.xjtu.edu.cn/archlinuxcn/$arch
```

```conf
## 阿里云 (Global CDN) (ipv4, http, https)
## Added: 2020-07-03
[archlinuxcn]
Server = https://mirrors.aliyun.com/archlinuxcn/$arch
```

更多可选镜像源可以查看[archlinuxcn repo](https://github.com/archlinuxcn/mirrorlist-repo)

### pip

`pip`的配置文件在`$HOME/.config/pip/pip.conf`中, 要换源, 只需在`pip.conf`中输入:

```conf
[global]
index-url=https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple
trusted-host=https://mirrors.tuna.tsinghua.edu.cn
timeout=120
```

### huggingface

使用`huggingface-hub`时, 设置环境变量:

```shell
export HF_ENDPOINT=https://hf-mirror.com
```

即可从`hf-mirror.com`上下载模型

## Docker proxy

### Docker pull

`docker pull` 命令是通过守护进程`dockerd`来执行的, 因此代理需要配置在`dockerd`中. 而`dockerd`常被`systemd`管控, 所以需要更新`systemd`配置

新建配置文件`/etc/systemd/system/docker.service.d/proxy.conf`, 写入如下配置

```conf
[Service]
Environment="HTTP_PROXY=http://$host:$port"
Environment="HTTPS_PROXY=http://$host:$port"
```

> 可以参考[仓库中给出的配置](../etc/systemd/system/docker.service.d/proxy.conf)

### Container

从容器中代理上网则需配置`$HOME/.docker/config.json`, 以下是一个示例:

```json
{
    "proxies": {
        "default": {
            "httpProxy": "http://$host:$port",
            "httpsProxy": "https://$host:$port",
            "noProxy": "localhost,127.0.0.1"
        }
    }
}
```

## APP proxy

要让KDE桌面应用能够经过系统代理, 需要:

1. 将`/usr/share/applications`中的`.desktop`文件复制到`~/.local/share/applications`中
2. 将`Exec`项改为如下格式:

```shell
Exec=http_proxy=http://127.0.0.1:$port https_proxy=http://127.0.0.1:$port <executable> --proxy-server="http://127.0.0.1:$port"
```
