# 进入目录并自动激活虚拟环境
function ce --wraps cd --description "cd and activate pyvenv"
    cd $argv; and act
end