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

#echo > /etc/opkg/distfeeds.conf
#sed -i '$a src/gz immortalwrt_core https://mirrors.pku.edu.cn/immortalwrt/releases/24.10.2/targets/rockchip/armv8/packages' /etc/opkg/distfeeds.conf
#sed -i '$a src/gz openwrt_base https://mirrors.pku.edu.cn/openwrt/releases/24.10.2/packages/aarch64_generic/base' /etc/opkg/distfeeds.conf
#sed -i '$a src/gz openwrt_luci https://mirrors.pku.edu.cn/openwrt/releases/24.10.2/packages/aarch64_generic/luci' /etc/opkg/distfeeds.conf
#sed -i '$a src/gz openwrt_packages https://mirrors.pku.edu.cn/openwrt/releases/24.10.2/packages/aarch64_generic/packages' /etc/opkg/distfeeds.conf
#sed -i '$a src/gz openwrt_routing https://mirrors.pku.edu.cn/openwrt/releases/24.10.2/packages/aarch64_generic/routing' /etc/opkg/distfeeds.conf
#sed -i '$a src/gz openwrt_telephony https://mirrors.pku.edu.cn/openwrt/releases/24.10.2/packages/aarch64_generic/telephony' /etc/opkg/distfeeds.conf

sed -i '$a src/gz kmods https://mirrors.pku.edu.cn/immortalwrt/releases/24.10.2/targets/rockchip/armv8/kmods/6.6.93-1-9e686cc1e0d5129337ca1ca28c2ab984' /etc/opkg/distfeeds.conf
sed -i '$a #src/gz kiddin9 https://dl.openwrt.ai/packages-24.10/aarch64_generic/kiddin9' /etc/opkg/customfeeds.conf

#sed -i 's/root::0:0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' /etc/shadow
#sed -i 's/root:::0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' /etc/shadow

#uci set network.usbwan=interface
#uci set network.usbwan.proto='dhcp'
#uci commit network

cp /etc/my-clash /etc/openclash/core/clash_meta

#uci set network.cfg030f15.macaddr="8C:DA:$(date +"%d:%H:%M:%S")"
#uci set network.cfg060f15.macaddr="9C:DA:$(date +"%d:%H:%M:%S")"
#uci commit network
#uci set wireless.default_radio0.macaddr='random'
#uci commit wireless

uci commit

#/etc/init.d/network restart

exit 0
