# 取消 CUDA 设备设置
function uncuda --description "unset CUDA visible devices"
    set -e CUDA_VISIBLE_DEVICES
end