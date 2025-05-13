#!/bin/sh

sed -i '/nss/d' /etc/apk/repositories.d/distfeeds.list
sed -i '/sqm/d' /etc/apk/repositories.d/distfeeds.list
sed -i '/qualcommax/d' /etc/apk/repositories.d/distfeeds.list
sed -i 's#downloads.immortalwrt.org#mirrors.pku.edu.cn/immortalwrt#g' /etc/apk/repositories.d/distfeeds.list
sed -i '$a https://mirrors.pku.edu.cn/immortalwrt/snapshots/targets/qualcommax/ipq60xx/kmods/6.6.85-1-633ed8724402e6b10849827a8dc66a67/packages.adb' /etc/apk/repositories.d/customfeeds.list
sed -i '$a https://mirrors.pku.edu.cn/immortalwrt/snapshots/targets/qualcommax/ipq60xx/packages/packages.adb' /etc/apk/repositories.d/customfeeds.list

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

# wifi设置
mymac=$(ifconfig br-lan 2>/dev/null | awk '/HWaddr/ {print $5}' | awk -F ":" '{print $5""$6 }' | tr 'a-z' 'A-Z')
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
/etc/init.d/network restart

exit 0
