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
sed -i '$a src/gz kmods https://mirror.nju.edu.cn/immortalwrt/releases/24.10.0/targets/ramips/mt7621/kmods/6.6.86-1-1e9929ab745a88954c978e6f878f4f58' /etc/opkg/customfeeds.conf
#sed -i '$a src/gz kiddin9 https://dl.openwrt.ai/packages-24.10/aarch64_generic/kiddin9' /etc/opkg/customfeeds.conf

uci add firewall rule
uci set firewall.@rule[-1].src='wan'
uci set firewall.@rule[-1].name='allow5422'
uci set firewall.@rule[-1].dest_port='5422'
uci set firewall.@rule[-1].target='ACCEPT'

OPENCLASH_FILE="/etc/config/openclash"
if [ -f "$OPENCLASH_FILE" ]; then
    mv /etc/my-clash /etc/openclash/core/clash_meta
fi

#/etc/init.d/network restart

exit 0
