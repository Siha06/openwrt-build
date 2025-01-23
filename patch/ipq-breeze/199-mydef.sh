#!/bin/sh


sed -i '$a src/gz openwrt_others https://mirror.nju.edu.cn/immortalwrt/releases/24.10-SNAPSHOT/targets/qualcommax/ipq807x/packages' /etc/opkg/customfeeds.conf
sed -i '$a src/gz openwrt_kmods https://mirror.nju.edu.cn/immortalwrt/releases/24.10-SNAPSHOT/targets/qualcommax/ipq807x/kmods/6.6.65-1-c9824125bf4a8028af70bed3c9a6ae77' /etc/opkg/customfeeds.conf

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

uci set network.lan.ip6assign=64
uci del network.globals.ula_prefix
uci commit

# wifi设置

exit 0
