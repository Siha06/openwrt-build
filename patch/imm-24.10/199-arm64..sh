#!/bin/sh

uci set network.wan.device='eth0'
uci del network.cfg030f15.ports
uci add_list network.cfg030f15.ports='eth1'
uci add_list network.cfg030f15.ports='eth2'
uci add_list network.cfg030f15.ports='eth3'
uci commit network
# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

#其他网络设置

uci commit

sed -ri '/check_signature/s@^[^#]@#&@' /etc/opkg.conf
sed -i 's#downloads.immortalwrt.org#mirrors.pku.edu.cn/immortalwrt#g' /etc/opkg/distfeeds.conf
sed -i '$a src/gz kmods https://mirrors.pku.edu.cn/immortalwrt/releases/24.10.0/targets/armsr/armv8/kmods/6.6.73-1-a7eafb055ecc4891236a188e564e21ff' /etc/opkg/customfeeds.conf
#sed -i '$a src/gz kiddin9 https://dl.openwrt.ai/packages-24.10/aarch64_generic/kiddin9' /etc/opkg/customfeeds.conf

tar -zxf /etc/clash-linux-arm64.tar.gz -C /etc/openclash/core/
mv /etc/openclash/core/clash /etc/openclash/core/clash_meta
rm -rf /etc/clash-linux-arm64.tar.gz

#/etc/init.d/network restart

exit 0
