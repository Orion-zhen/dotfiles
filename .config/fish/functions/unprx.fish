# 取消代理设置
function unprx --description "unset proxy"
    if not set -q http_proxy -o not set -q https_proxy
        echo "No proxies are set yet"
    else
        echo "Unset $http_proxy and $https_proxy"
        set -e http_proxy
        set -e https_proxy
    end
end