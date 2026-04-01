#!/bin/sh
generate_mac() {
    # 生成随机数并格式化
    local rand1=$(hexdump -n 1 -e '1/1 "%02x"' /dev/urandom 2>/dev/null)
    local rand2=$(hexdump -n 1 -e '1/1 "%02x"' /dev/urandom 2>/dev/null)
    local rand3=$(hexdump -n 1 -e '1/1 "%02x"' /dev/urandom 2>/dev/null)
    local rand4=$(hexdump -n 1 -e '1/1 "%02x"' /dev/urandom 2>/dev/null)
    local rand5=$(hexdump -n 1 -e '1/1 "%02x"' /dev/urandom 2>/dev/null)
    local rand6=$(hexdump -n 1 -e '1/1 "%02x"' /dev/urandom 2>/dev/null)
    
    # 修改第一个字节：确保第二位为 2,6,A,E
    local first_byte_dec=$((0x$rand1))
    local modified_byte=$((first_byte_dec & 0xFC | 0x02))
    local first_byte_new=$(printf "%02x" $modified_byte)
    
    echo "${first_byte_new}:${rand2}:${rand3}:${rand4}:${rand5}:${rand6}"
}
# 生成两个MAC
NEW_MAC1=$(generate_mac)
NEW_MAC2=$(generate_mac)

uci set network.@device[1].macaddr="$NEW_MAC1"
uci set network.@device[2].macaddr="$NEW_MAC2"

OCTET2=$((RANDOM % 254 + 1))
OCTET3=$((RANDOM % 254 + 1))
NEW_IP="10.${OCTET2}.${OCTET3}.1"
uci set network.lan.ipaddr="$NEW_IP"

# ====== SSID ======
BRANDS=("Xiaomi" "Huawei" "TP-LINK" "ASUS" "Redmi" "Tenda" "Netcore" "H3C" "CMCC" "ChinaNet" "ChinaUnicom" "NETGEAR")
LEN=4
INDEX=$(($RANDOM % ${#BRANDS[@]}))
PREFIX=${BRANDS[$INDEX]}
RAND=$(tr -dc A-Za-z0-9 </dev/urandom | head -c $LEN)
SSID="${PREFIX}-${RAND}"

uci set wireless.default_radio0.ssid="${SSID}-2.4G"
uci set wireless.default_radio1.ssid="${SSID}-5G"

uci commit network
uci commit wireless
uci commit
/etc/init.d/network restart
exit 0
