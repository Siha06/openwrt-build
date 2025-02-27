#!/bin/sh


# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

#其他网络设置
uci del wireless.radio0.disabled
uci del wireless.default_radio0.disabled
uci commit wireless

uci set network.usbwan=interface
uci set network.usbwan.proto='dhcp'
uci set network.usbwan.device='usb0'
uci commit network

uci commit

sed -ri '/check_signature/s@^[^#]@#&@' /etc/opkg.conf
sed -i 's#downloads.openwrt.org#mirrors.pku.edu.cn/openwrt#g' /etc/opkg/distfeeds.conf
sed -i '$a src/gz kmods https://mirrors.pku.edu.cn/openwrt/releases/24.10.0/targets/rockchip/armv8/kmods/6.6.73-1-f35e93bc2c89b98d107e57cdea041972' /etc/opkg/customfeeds.conf
sed -i '$a src/gz kiddin9 https://dl.openwrt.ai/packages-24.10/aarch64_generic/kiddin9' /etc/opkg/customfeeds.conf

wifi up
/etc/init.d/network restart

exit 0
