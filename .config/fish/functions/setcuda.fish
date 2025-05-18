# 设置 CUDA 可见设备，默认设备为 0
function setcuda --description "set CUDA visible devices"
    set default_device 0
    if test (count $argv) -ge 1
        set device $argv[1]
    else
        set device $default_device
    end
    echo "cuda visible device = $device"
    set -gx CUDA_VISIBLE_DEVICES $device
end