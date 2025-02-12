# 连接 WiFi
function wifictl --description "connect to WiFi"
    if test (count $argv) -lt 2
        echo "Usage: wifictl wifi_id password"
        return 1
    end
    set wifi_id $argv[1]
    set password $argv[2]
    nmcli device wifi connect $wifi_id password $password
end