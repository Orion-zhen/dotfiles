# APP proxy

要让桌面应用能够经过系统代理, 需要:

1. 将`/usr/share/applications`中的`.desktop`文件复制到`~/.local/share/applications`中
2. 将`Exec`项改为如下格式:

```shell
Exec=http_proxy=http://127.0.0.1:$port https_proxy=http://127.0.0.1:$port <executable> --proxy-server="http://127.0.0.1:$port"
```
