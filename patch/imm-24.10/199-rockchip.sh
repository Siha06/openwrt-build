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
sed -i '$a src/gz kmods https://mirrors.pku.edu.cn/immortalwrt/releases/24.10.1/targets/rockchip/armv8/kmods/6.6.86-1-422144fea623288f7402e1a9a15724c8' /etc/opkg/distfeeds.conf
sed -i '$a #src/gz kiddin9 https://dl.openwrt.ai/packages-24.10/aarch64_generic/kiddin9' /etc/opkg/customfeeds.conf

sed -i 's/root::0:0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' /etc/shadow
sed -i 's/root:::0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' /etc/shadow

#uci set network.usbwan=interface
#uci set network.usbwan.proto='dhcp'
#uci commit network

OPENCLASH_FILE="/etc/config/openclash"
if [ -f "$OPENCLASH_FILE" ]; then
    mv /etc/my-clash /etc/openclash/core/clash_meta
fi

#uci set network.cfg030f15.macaddr="8C:DA:$(date +"%d:%H:%M:%S")"
#uci set network.cfg060f15.macaddr="9C:DA:$(date +"%d:%H:%M:%S")"
#uci commit network
#uci set wireless.default_radio0.macaddr='random'
#uci commit wireless

uci commit
#mv /etc/my-crontabs /etc/crontabs/root
#/etc/init.d/network restart

exit 0
