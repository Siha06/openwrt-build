#!/bin/sh

sed -i 's/immortalwrt/openwrt/g' /etc/opkg/distfeeds.conf
sed -i '$a src/gz openwrt_others https://mirror.nju.edu.cn/immortalwrt/releases/24.10-SNAPSHOT/targets/qualcommax/ipq807x/packages' /etc/opkg/customfeeds.conf
sed -i '$a src/gz openwrt_kmods https://mirror.nju.edu.cn/immortalwrt/releases/24.10-SNAPSHOT/targets/qualcommax/ipq807x/kmods/6.6.65-1-c9824125bf4a8028af70bed3c9a6ae77' /etc/opkg/customfeeds.conf

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

#uci set network.lan.ip6assign=64
#uci del network.globals.ula_prefix
#uci set dhcp.lan.dns_service='0'

uci del dhcp.lan.ra
uci del dhcp.lan.ra_slaac
uci del dhcp.lan.ra_flags
uci del dhcp.lan.dhcpv6
uci del dhcp.lan.dns_service
uci commit dhcp
# uci del network.wan6
uci del network.lan.ip6assign
uci del network.globals.ula_prefix
uci commit network
uci commit

# wifi设置
uci set wireless.default_radio0.ssid=WiFi-$(cat /sys/class/ieee80211/phy0/macaddress|awk -F ":" '{print $5""$6 }' | tr 'a-z' 'A-Z')-5G
uci set wireless.default_radio1.ssid=WiFi-$(cat /sys/class/ieee80211/phy0/macaddress|awk -F ":" '{print $5""$6 }' | tr 'a-z' 'A-Z')-2.4G
uci set wireless.default_radio0.encryption=psk2+ccmp
uci set wireless.default_radio1.encryption=psk2+ccmp
uci set wireless.default_radio0.key=password
uci set wireless.default_radio1.key=password

#uci set network.usbwan=interface
#uci set network.usbwan.proto='dhcp'
#uci set network.usbwan.device='usb0'
#uci commit network

uci commit

#sed -i 's/root::0:0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' /etc/shadow
#sed -i 's/root:::0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' /etc/shadow

cp /etc/my-clash /etc/openclash/core/clash_meta

/etc/init.d/network restart
#sleep 2
#/etc/init.d/system restart

exit 0
