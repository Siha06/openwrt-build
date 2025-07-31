#!/bin/sh

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

#其他网络设置

uci commit

sed -i '/modem/d' /etc/opkg/distfeeds.conf
sed -ri '/check_signature/s@^[^#]@#&@' /etc/opkg.conf
sed -i 's#downloads.immortalwrt.org#mirrors.pku.edu.cn/immortalwrt#g' /etc/opkg/distfeeds.conf
sed -i '$a src/gz kmods https://downloads.immortalwrt.org/releases/24.10.2/targets/ramips/mt7621/kmods/6.6.93-1-730c62a2d59c0c43f493ba6554a36be8' /etc/opkg/customfeeds.conf
#sed -i '$a src/gz kiddin9 https://dl.openwrt.ai/packages-24.10/aarch64_generic/kiddin9' /etc/opkg/customfeeds.conf

# wifi设置
#uci set wireless.default_radio0.ssid=WiFi-$(cat /sys/class/ieee80211/phy0/macaddress|awk -F ":" '{print $5""$6 }' | tr 'a-z' 'A-Z')-5G
#uci set wireless.default_radio1.ssid=WiFi-$(cat /sys/class/ieee80211/phy0/macaddress|awk -F ":" '{print $5""$6 }' | tr 'a-z' 'A-Z')-2.4G
uci set wireless.default_radio0.ssid=OpenWrt-2.4G
uci set wireless.default_radio1.ssid=OpenWrt-5G
uci set wireless.default_radio0.encryption=psk2+ccmp
uci set wireless.default_radio1.encryption=psk2+ccmp
uci set wireless.default_radio0.key=password
uci set wireless.default_radio1.key=password

#uci add firewall rule
#uci set firewall.@rule[-1].src='wan'
#uci set firewall.@rule[-1].name='allow5422'
#uci set firewall.@rule[-1].dest_port='5422'
#uci set firewall.@rule[-1].target='ACCEPT'
#uci commit firewall

uci set network.usbwan=interface
uci set network.usbwan.proto='dhcp'
uci set network.usbwan.device='usb0'

#uci del firewall.cfg02dc81.network
#uci add_list firewall.cfg02dc81.network='lan'
#uci add_list firewall.cfg02dc81.network='wifi1'
#uci del firewall.cfg03dc81.network
#uci add_list firewall.cfg03dc81.network='wan'
uci add_list firewall.cfg03dc81.network='usbwan'

#/etc/init.d/firewall restart >/dev/null 2>&1

cp /etc/my-clash /etc/openclash/core/clash_meta

uci commit wireless
uci commit network
uci commit firewall

/etc/init.d/network restart >/dev/null 2>&1
/etc/init.d/firewall restart >/dev/null 2>&1
/etc/init.d/dnsmasq restart >/dev/null 2>&1
/etc/init.d/dropbear restart >/dev/null 2>&1

exit 0
