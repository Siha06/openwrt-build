#!/bin/sh

sed -ri '/check_signature/s@^[^#]@#&@' /etc/opkg.conf
sed -i '/nss/d' /etc/opkg/distfeeds.conf
sed -i '/sqm/d' /etc/opkg/distfeeds.conf
sed -i '/qualcommax/d' /etc/opkg/distfeeds.conf
sed -i '/video/d' /etc/opkg/distfeeds.conf
sed -i 's#downloads.immortalwrt.org/snapshots#mirrors.pku.edu.cn/immortalwrt/releases/24.10-SNAPSHOT#g' /etc/opkg/distfeeds.conf
sed -i '$a src/gz openwrt_others https://mirrors.pku.edu.cn/immortalwrt/releases/24.10-SNAPSHOT/targets/qualcommax/ipq807x/packages' /etc/opkg/customfeeds.conf

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

uci set luci.main.mediaurlbase=/luci-static/bootstrap
uci commit luci

# wifi设置
mymac=$(cat /sys/class/net/br-lan/address 2>/dev/null | awk -F: '{print $5 $6}' | tr 'a-z' 'A-Z')
uci set wireless.default_radio0.ssid=WiFi-${mymac}-5G
uci set wireless.default_radio1.ssid=WiFi-${mymac}-2.4G
uci commit wireless

#uci set network.lan.ipaddr='192.168.1.1'
#uci set network.usbwan=interface
#uci set network.usbwan.proto='dhcp'
#uci set network.usbwan.device='eth0'
#uci add_list firewall.cfg03dc81.network='usbwan'
#uci commit network
uci commit

OPENCLASH_FILE="/etc/config/openclash"
if [ -f "$OPENCLASH_FILE" ]; then
    mv /etc/my-clash /etc/openclash/core/clash_meta
fi
#/etc/init.d/network restart

exit 0
