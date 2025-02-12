# 在 Docker 容器中执行命令，默认命令为 /bin/bash
function docex --description "exec into a Docker container, default is /bin/bash"
    if test (count $argv) -lt 1
        echo "Usage: docex container_name [cmd]"
        return 1
    end
    set container_name $argv[1]
    if test (count $argv) -ge 2
        set cmd $argv[2]
    else
        set cmd /bin/bash
    end
    docker exec -it $container_name $cmd
end