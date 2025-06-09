#!/bin/bash
START=00

start() {
    # 定义MAC地址前缀数组
    prefixes=("9C:66:97" "94:0D:4B" "04:E3:87" "48:A1:70" "F8:C6:50" "60:B9:C0" "8C:94:61" "68:79:09" "0C:12:62" "98:6C:F5" "4C:CB:F5" "78:E8:B6" "F0:84:C9" "E0:C3:F3" "F4:6D:E2" "DC:E5:D8" "68:94:4A" "74:33:E9" "9C:B4:00" "4C:4C:D8" "FC:8A:F7" "60:6B:B3" "F0:ED:19" "04:6E:CB" "64:BA:A4" "94:9F:8B" "30:C6:AB" "D4:95:5D" "E4:5B:B3" "38:AA:20" "70:6A:C9" "BC:41:A0" "64:85:05" "E4:60:4D" "F4:E8:4F" "14:CA:56" "38:F6:CF" "E4:BD:4B" "8C:68:C8" "EC:82:63" "30:99:35" "0C:72:D9" "9C:6F:52" "60:14:66" "F8:A3:4F" "E0:7C:13" "F4:1F:88" "98:13:33" "A0:91:C8" "D4:76:EA" "08:18:1A" "40:16:9F" "F4:EC:38" "54:E6:FC" "F8:D1:11" "B0:48:7A" "5C:63:BF" "00:1D:0F" "00:14:78" "6C:E8:73" "10:FE:ED" "EC:88:8F" "64:66:B3" "14:CF:92" "20:DC:E6" "74:EA:3A" "D8:5D:4C" "94:0C:6D" "E0:05:C5" "00:27:19" "00:25:86" "14:CC:20" "C4:6E:1F" "64:56:01" "F0:F3:36" "BC:46:99" "80:89:17" "50:FA:84" "44:B3:2D" "88:25:93" "EC:26:CA" "F4:83:CD" "FC:D7:33" "5C:89:9A" "00:0A:EB" "B4:0F:3B" "CC:2D:21" "B8:3A:08" "58:D9:D5" "50:0F:F5" "E8:65:D4" "08:CB:E5" "B0:DF:C1" "04:95:E6" "C8:3A:35" "08:40:F3" "D8:32:14" "50:2B:73" "04:CF:8C" "40:31:3C" "7C:49:EB" "28:6C:07" "EC:41:18" "78:11:DC" "50:64:2B" "34:CE:00" "D4:5E:EC" "3C:BD:3E" "E0:B6:55" "C8:28:32" "04:7A:0B" "6C:0D:C4" "EC:FA:5C" "8C:5A:F8" "E4:DB:6D" "78:53:33" "E4:45:19" "1C:8B:EF" "68:B8:BB" "44:71:47" "3C:2C:A6" "20:72:A9" "1C:2A:B0" "DC:7C:F7" "7C:6A:60" "A8:61:DF" "50:29:7B" "94:FF:61" "1C:41:76" "AC:5A:EE" "44:C8:74" "18:69:DA" "C4:33:06" "EC:E7:C2" "F4:BF:BB" "08:15:AE" "48:1F:66" "DC:15:2D" "EC:9B:2D" "6C:0F:0B" "FC:2E:19" "A4:1B:34" "F8:48:FD" "14:A1:DF" "A0:21:AA" "CC:96:A2" "BC:9E:2C" "94:BE:09" "04:4F:7A" "78:10:53" "0C:14:D2" "CC:5C:DE" "78:C3:13" "74:AD:B7" "90:47:3C" "10:3D:3E" "AC:71:0C" "B4:D0:A9" "70:89:CC" "04:A9:59" "70:81:85" "14:84:77" "14:96:2D" "E8:78:EE" "8C:94:6A" "98:20:44" "7C:DE:78" "A8:C9:8A" "90:F7:B2" "40:FE:95" "70:C6:DD" "90:23:B4" "88:2A:5E" "84:65:69" "98:F1:81" "10:19:65" "6C:E5:F7" "70:3A:A6" "30:80:9B" "A4:FA:76" "50:98:B8" "08:68:8D" "70:57:BF" "44:1A:FA" "90:E7:10" "88:DF:9E" "9C:E8:95" "30:7B:AC" "AC:CE:92" "10:3F:8C" "08:3B:E9" "10:B6:5E" "9C:09:71" "80:61:6C" "7C:10:C9" "88:D7:F6" "90:E6:BA" "9C:5C:8E" "A0:36:BC" "A8:5E:45" "AC:22:0B" "AC:9E:17" "B0:6E:BF" "BC:AE:C5" "BC:EE:7B" "C8:60:00" "C8:7F:54" "CC:28:AA" "D0:17:C2" "D4:5D:64" "D8:50:E6" "E0:3F:49" "E0:CB:4E" "E8:9C:25" "F0:2F:74" "F0:79:59" "F4:6D:04" "F8:32:E4" "FC:34:97" "FC:C2:33" "9C:E3:30" "B4:DF:91" "B8:AB:61" "08:F1:B3" "CC:9C:3E" "88:15:44" "6C:DE:A9" "A8:46:9D" "CC:03:D9" "0C:8D:DB" "6C:7F:0C" "CC:6E:2A" "E0:D3:B4" "BC:B1:D3" "AC:D3:1D" "2C:3F:0B" "6C:EF:BD" "B8:B4:C9" "C4:14:A2" "68:49:92" "BC:DB:09" "00:18:0A" "B8:07:56" "34:56:FE" "6C:C3:B2" "C4:D6:66" "14:9F:43" "E4:55:A8" "F8:9E:28" "38:84:79" "E0:CB:BC" "68:3A:1E" "8C:88:81" "BC:33:40" "00:84:1E" "0C:7B:C8" "C4:8B:A3" "AC:17:C8" "98:18:88" "4C:C8:A1" "E0:55:3D" "00:1B:67" "E8:0A:B9" "48:1B:A4" "6C:03:B5" "90:88:55" "68:71:61" "4C:EC:0F" "5C:64:F1" "5C:3E:06" "90:76:9F" "4C:77:66" "00:5C:C2" "00:4B:F3" "E4:F3:F5" "C0:A5:DD" "C0:25:2F" "10:63:4B" "04:4B:A5" "D4:84:09" "44:F9:71" "38:6B:1C" "50:89:65" "84:68:C8" "5C:92:5E" "B8:55:10" "14:4D:67" "40:EE:15" "78:44:76" "1C:56:8E" "F4:28:53" "00:0E:E8" "00:05:5D" "00:80:C8" "B4:37:D8" "00:50:BA" "00:17:9A" "00:1C:F0" "00:1E:58" "00:22:B0" "00:24:01" "5C:D9:98" "40:86:CB" "64:29:43" "F0:7D:68" "00:15:E9" "00:1B:11" "00:26:5A" "00:19:5B" "00:0F:3D" "3C:33:32" "18:56:44" "9C:69:D1" "84:46:FE" "D8:29:18" "30:FB:B8" "44:D7:91" "D4:6B:A6" "CC:05:77" "D4:62:EA" "54:BA:D6" "94:0B:19" "70:C7:F2" "88:F5:6E" "C8:C2:FA" "24:16:6D" "CC:64:A6" "F8:9A:78" "88:F8:72" "EC:56:23" "18:02:2D" "48:F8:DB" "80:7D:14" "20:28:3E" "88:10:8F" "F4:63:1F" "A4:9B:4F" "34:2E:B6" "9C:C9:EB" "38:94:ED" "10:0C:6B" "78:D2:94" "B0:7F:B9" "08:BD:43" "4C:60:DE" "C4:3D:C7" "40:5D:82" "DC:EF:09" "28:94:01" "44:A5:6E" "28:80:88" "14:59:C0" "CC:40:D0" "08:02:8E" "9C:3D:CF" "C4:04:15" "E8:FC:AF" "84:1B:5E" "2C:B0:5D" "A0:21:B7" "C0:FF:D4" "6C:B0:CE" "00:8E:F2" "9C:D3:6D" "00:24:B2" "00:1B:2F" "00:1F:33" "E0:46:EE" "94:18:65" "B0:39:56" "A0:63:91" "20:E5:2A" "44:94:FC" "E0:91:F5" "00:14:6C" "00:1E:2A" "F0:74:8D" "10:82:3D" "E0:5D:54" "00:74:9C" "C0:B8:E6" "FC:59:9F" "14:14:4B" "48:81:D4" "28:D0:F5" "54:16:51" "9C:2B:A6" "58:69:6C" "EC:B9:70" "C4:70:AB" "30:0D:9E" "00:11:AD" "C8:CD:55" "C4:B2:5B" "98:4A:6B" "58:B4:BB" "D4:31:27" "70:42:D3" "70:85:C4" "78:45:58" "AC:8B:A9" "9C:05:D6" "28:70:4E" "84:78:48" "04:18:D6" "24:A4:3C" "44:D9:E7" "D0:21:F9" "70:A7:41" "F4:E2:C6" "D8:B3:70" "B4:FB:E4" "68:72:51" "FC:EC:DA" "94:2A:6F" "00:15:6D" "00:27:22" "DC:9F:DB" "18:E8:29" "74:AC:B9" "F4:92:BF" "68:D7:9A" "1C:6A:1B" "0C:B9:83" "2C:B3:01" "40:D4:F6" "68:A7:B4" "08:E0:21" "90:FF:D6" "C0:28:0B" "9C:EA:97" "C8:9B:AD" "94:32:C1" "EC:53:82" "48:BD:A7" "38:65:04" "A0:FB:83" "70:A6:BD" "B8:B1:EA" "78:E6:1C" "60:F0:4D" "48:C1:EE" "14:61:A4" "B0:81:01" "20:04:F3" "28:12:93" "EC:64:88" "98:BE:DC" "E4:27:61" "A0:69:74" "00:18:F7" "44:90:46" "94:F6:F2" "08:84:FB" "1C:C9:92" "0C:D8:6C" "38:01:9F" "00:5C:86" "D4:55:BE" "F4:6A:92" "78:EB:14" "DC:B3:47" "74:C3:30" "70:4E:66" "18:0E:AC" "9C:7F:81" "74:54:27" "8C:78:D7" "60:EE:5C" "00:5A:39" "D4:83:04" "44:97:5A" "00:10:92" "00:90:2F" "00:1D:7E" "00:14:BF" "48:F8:B3" "C0:C1:C0" "C8:D7:19" "00:0E:08" "00:0C:41" "00:16:B6" "00:18:F8" "00:23:69" "00:22:6B" "00:18:39" "C8:B3:73" "00:25:9C" "00:21:29" "00:1C:10" "00:0F:66" "20:AA:4B" "98:FC:11" "68:7F:74" "00:12:17" "00:13:10" "00:1E:E5" "58:6D:8F" "00:1A:70" "2C:15:E1" "2C:B2:1A" "98:BB:99" "D8:C8:E9" "74:7D:24" "FC:7C:02" "68:DB:54" "CC:81:DA"
    )

    # 获取前缀数组的长度
    prefix_length=${#prefixes[@]}
    # 生成一个随机数作为索引
    indexMAC=$((RANDOM % prefix_length))
    # 获取随机选择的前缀
    selected_prefix=${prefixes[$indexMAC]}

    # 为 @wifi-iface[0] 生成随机的后缀部分
    random_suffix_0=$(hexdump -n3 -e '/1 ":%02x"' /dev/urandom)
    # 生成 @wifi-iface[0] 的新 MAC 地址
    NEW_MAC_0="${selected_prefix}${random_suffix_0}"

    # 为 @wifi-iface[1] 生成随机的后缀部分
    random_suffix_1=$(hexdump -n3 -e '/1 ":%02x"' /dev/urandom)
    # 生成 @wifi-iface[1] 的新 MAC 地址
    NEW_MAC_1="${selected_prefix}${random_suffix_1}"

    # 修改 /etc/config/wireless 文件中的 macaddr 选项
    uci set wireless.@wifi-iface[0].macaddr="$NEW_MAC_0"
    uci set wireless.@wifi-iface[1].macaddr="$NEW_MAC_1"
    # chmod +x /lib/QINGYINMAC1.sh
    # /lib/QINGYINMAC1.sh start $NEW_MAC
    array=("ZTE" "TP-Link" "Tenda" "Xiaomi" "ChinaNet" "360WiFi" "CMCC" "H3C" "ASUS" "CN" "Cisco" "MERCURY" "TOTOLINK" "Netgear" "rujie" "TP" "UBNT" "honor" "FAST" "CU" "HUAWEI" "Netcore" "LINKSYS" "Phicomm" "AFR" "D-Link")
    array_length=${#array[@]}
    index=$((RANDOM % array_length))
    random_string=${array[$index]}
    NEW_SSID5G1="${random_string}01_$(tr -dc 'A-F0-9' < /dev/urandom | head -c 6)_5G"
    index=$((RANDOM % array_length))
    random_string=${array[$index]}
    NEW_SSID5G2="${random_string}27_$(tr -dc 'A-F0-9' < /dev/urandom | head -c 6)"
    index=$((RANDOM % array_length))
    random_string=${array[$index]}
    NEW_SSID5G3="${random_string}28_$(tr -dc 'A-F0-9' < /dev/urandom | head -c 6)"
    index=$((RANDOM % array_length))
    random_string=${array[$index]}
    NEW_SSID5G4="${random_string}29_$(tr -dc 'A-F0-9' < /dev/urandom | head -c 6)"
    index=$((RANDOM % array_length))
    random_string=${array[$index]}
    NEW_SSID5G5="${random_string}30_$(tr -dc 'A-F0-9' < /dev/urandom | head -c 6)"
    # 轻音：指定WiFi顺序生成
    uci set wireless.@wifi-iface[0].ssid="$NEW_SSID5G1"
    uci set wireless.@wifi-iface[1].ssid="$NEW_SSID5G1"
    uci set wireless.@wifi-iface[2].ssid="$NEW_SSID5G2"
    uci set wireless.@wifi-iface[3].ssid="$NEW_SSID5G3"
    uci set wireless.@wifi-iface[4].ssid="$NEW_SSID5G4"
    uci set wireless.@wifi-iface[5].ssid="$NEW_SSID5G5"
    # 轻音:永久存储名称防止自动还原
    uci commit wireless
    # 轻音:重启SH服务即可生效！
    # /etc/init.d/network restart
    reboot
}

start