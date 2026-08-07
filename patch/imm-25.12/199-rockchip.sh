#!/bin/sh


# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''


sed -i '/passwall/d' /etc/apk/repositories.d/distfeeds.list
sed -i '/helloworld/d' /etc/apk/repositories.d/distfeeds.list
sed -i '/modem/d' /etc/apk/repositories.d/distfeeds.list
sed -i '/Modem/d' /etc/apk/repositories.d/distfeeds.list
sed -i '/video/d' /etc/apk/repositories.d/distfeeds.list
sed -i '/targets/d' /etc/apk/repositories.d/distfeeds.list

sed -i '$a https://mirrors.vsean.net/openwrt/releases/25.12.1/targets/rockchip/armv8/kmods/6.12.94-1-9695dbb0de913313770c73e57b594a48/packages.adb' /etc/apk/repositories.d/distfeeds.list
sed -i '$a https://mirrors.vsean.net/openwrt/releases/25.12.1/targets/rockchip/armv8/packages/packages.adb' /etc/apk/repositories.d/distfeeds.list



uci commit

#/etc/init.d/network restart

exit 0
