#!/bin/sh

# 设置默认防火墙规则，方便虚拟机首次访问 WebUI
#uci set firewall.@zone[1].input='ACCEPT'

# 设置主机名映射，解决安卓原生 TV 无法联网的问题
#uci add dhcp domain
#uci set "dhcp.@domain[-1].name=time.android.com"
#uci set "dhcp.@domain[-1].ip=203.107.6.88"


# 根据网卡数量配置网络
count=0
for iface in /sys/class/net/*; do
  iface_name=$(basename "$iface")
  # 检查是否为物理网卡（排除回环设备和无线设备）
  if [ -e "$iface/device" ] && echo "$iface_name" | grep -Eq '^eth|^en'; then
    count=$((count + 1))
  fi
done

# 网络设置
if [ "$count" -eq 1 ]; then
  uci set network.lan.proto='dhcp'
  uci set dhcp.lan.ignore='1'
elif [ "$count" -gt 1 ]; then
  uci set network.lan.ip6assign='64'
fi

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

#其他网络设置
uci set wireless.radio0.disabled=0
uci set wireless.radio1.disabled=0
uci set network.lan.ip6ifaceid='eui64'
uci commit

# 设置编译作者信息
#FILE_PATH="/etc/openwrt_release"
#NEW_DESCRIPTION="OpenWrt V25.1.20"
#sed -i "s/DISTRIB_DESCRIPTION='[^']*'/DISTRIB_DESCRIPTION='$NEW_DESCRIPTION'/" "$FILE_PATH"

sed -ri '/check_signature/s@^[^#]@#&@' /etc/opkg.conf
sed -i 's#downloads.openwrt.org#mirrors.pku.edu.cn/openwrt#g' /etc/opkg/distfeeds.conf
sed -i '$a src/gz kmods https://mirrors.pku.edu.cn/openwrt/releases/24.10.0-rc5/targets/x86/64/kmods/6.6.69-1-5509b70aad67fe27570100db8e5f3b66' /etc/opkg/customfeeds.conf
sed -i '$a src/gz kiddin9 https://dl.openwrt.ai/packages-24.10/x86_64/kiddin9' /etc/opkg/customfeeds.conf
wifi up

exit 0
