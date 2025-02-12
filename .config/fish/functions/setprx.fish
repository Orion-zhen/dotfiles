# 设置代理，如果传入两个参数，第一个为 IP，第二个为端口；若只传入一个参数，则 IP 固定为 127.0.0.1
function setprx --description "set proxy"
    if test (count $argv) -eq 2
        set -x http_proxy "http://$argv[1]:$argv[2]"
        set -x https_proxy "http://$argv[1]:$argv[2]"
        echo "Proxy set to $argv[1]:$argv[2]"
    else if test (count $argv) -eq 1
        set -x http_proxy "http://127.0.0.1:$argv[1]"
        set -x https_proxy "http://127.0.0.1:$argv[1]"
        echo "Proxy set to 127.0.0.1:$argv[1]"
    else
        echo "Usage: setprx [IP] [PORT]"
        echo "or     setprx [PORT]"
    end
end