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
sed -i '$a src/gz kmods https://mirrors.pku.edu.cn/immortalwrt/releases/24.10.1/targets/armsr/armv8/kmods/6.6.73-1-ad0abd17f62ba101da503a2ba8a778de' /etc/opkg/customfeeds.conf
#sed -i '$a src/gz kiddin9 https://dl.openwrt.ai/packages-24.10/aarch64_generic/kiddin9' /etc/opkg/customfeeds.conf

OPENCLASH_FILE="/etc/config/openclash"
if [ -f "$OPENCLASH_FILE" ]; then
    mv /etc/my-clash /etc/openclash/core/clash_meta
fi

uci del network.wan
uci del network.wan6
uci del network.cfg030f15.ports
uci add_list network.cfg030f15.ports=eth0
uci add_list network.cfg030f15.ports=eth1
uci commit network
uci commit
/etc/init.d/network restart

exit 0
