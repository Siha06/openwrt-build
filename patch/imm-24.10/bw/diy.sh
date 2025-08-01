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

sed -i '$a src/gz kmods https://mirrors.pku.edu.cn/immortalwrt/releases/24.10.2/targets/ramips/mt7621/kmods/6.6.93-1-730c62a2d59c0c43f493ba6554a36be8' /etc/opkg/distfeeds.conf

sed -i 's/root::0:0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' /etc/shadow
sed -i 's/root:::0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' /etc/shadow
echo >  /etc/rc.local
sed -i '$a ./etc/my-mac.sh' /etc/rc.local
sed -i '$a exit 0' /etc/rc.local

#cp /etc/my-clash /etc/openclash/core/clash_meta

#uci set network.cfg030f15.macaddr="8C:DA:$(date +"%d:%H:%M:%S")"
#uci set network.cfg060f15.macaddr="9C:DA:$(date +"%d:%H:%M:%S")"
#uci commit network
uci set wireless.default_radio0.macaddr='random'
uci set wireless.default_radio1.macaddr='random'
uci set wireless.default_radio1.ssid=OpenWrt-5G
uci set wireless.default_radio0.ssid=OpenWrt-2.4G
uci set wireless.default_radio0.encryption=psk2+ccmp
uci set wireless.default_radio1.encryption=psk2+ccmp
uci set wireless.default_radio0.key=password
uci set wireless.default_radio1.key=password
uci commit wireless
chmod +x /etc/my-mac.sh
./etc/my-mac.sh
uci commit

/etc/init.d/network restart

exit 0
