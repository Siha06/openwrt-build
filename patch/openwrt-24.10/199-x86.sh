#!/bin/sh

uci -q get system.@imm_init[0] > "/dev/null" || uci -q add system imm_init > "/dev/null"

if ! uci -q get system.@imm_init[0].system_chn > "/dev/null"; then
	uci -q batch <<-EOF
		set system.@system[0].timezone="CST-8"
		set system.@system[0].zonename="Asia/Shanghai"

		delete system.ntp.server
		add_list system.ntp.server="ntp.tencent.com"
		add_list system.ntp.server="ntp1.aliyun.com"
		add_list system.ntp.server="ntp.ntsc.ac.cn"
		add_list system.ntp.server="cn.ntp.org.cn"

		set system.@imm_init[0].system_chn="1"
		commit system
	EOF
fi

sed -i "/log-facility/d" "/etc/dnsmasq.conf"
echo "log-facility=/dev/null" >> "/etc/dnsmasq.conf"

ln -sf "/sbin/ip" "/usr/bin/ip"

# 设置默认防火墙规则，方便虚拟机首次访问 WebUI
#uci set firewall.@zone[1].input='ACCEPT'

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''


#uci set luci.main.mediaurlbase=/luci-static/infinityfreedom
#uci commit luci

uci commit

sed -ri '/check_signature/s@^[^#]@#&@' /etc/opkg.conf
sed -i 's#downloads.openwrt.org#mirrors.pku.edu.cn/openwrt#g' /etc/opkg/distfeeds.conf
sed -i '$a src/gz kmods https://mirrors.pku.edu.cn/openwrt/releases/24.10.1/targets/x86/64/kmods/6.6.86-1-af351158cfb5febf5155a3aa53785982' /etc/opkg/customfeeds.conf
sed -i '$a #src/gz kiddin9 https://dl.openwrt.ai/packages-24.10/x86_64/kiddin9' /etc/opkg/customfeeds.conf

OPENCLASH_FILE="/etc/config/openclash"
if [ -f "$OPENCLASH_FILE" ]; then
    tar -zxf /etc/clash-linux-amd64.tar.gz -C /etc/openclash/core/
    mv /etc/openclash/core/clash /etc/openclash/core/clash_meta
    rm -rf /etc/clash-linux-amd64.tar.gz
fi


# 根据网卡数量配置网络
eth_count=0
for iface in /sys/class/net/*; do
  iface_name=$(basename "$iface")
  # 检查是否为物理网卡（排除回环设备和无线设备）
  if [ -e "$iface/device" ] && echo "$iface_name" | grep -Eq '^eth|^en'; then
    eth_count=$((count + 1))
  fi
done
# 统计eth接口数量，大于1个则将eth0设为wan其它网口设为lan，只有1个则设置成DHCP模式
#丢弃eth_count=$(ls /sys/class/net | grep -c '^eth')
if [ $eth_count -gt 1 ]; then
    uci set network.lan.ipaddr='192.168.23.1'

    uci del dhcp.lan.ra_slaac
    uci del dhcp.lan.dhcpv6
    uci del dhcp.lan.ra_flags
    uci add_list dhcp.lan.ra_flags='none'
    uci set dhcp.lan.dns_service='0'

    uci del network.wan6
    uci del network.globals.packet_steering
    uci del network.globals.ula_prefix
    uci set network.lan.ip6assign='64'
    uci set network.lan.ip6ifaceid='eui64'

    uci set network.wan.device='eth0'
    uci del network.cfg030f15.ports
    ls /sys/class/net | awk '/^eth[0-9]+$/ && $0 != "eth0" {print "uci add_list network.cfg030f15.ports="$0}' | sh   
else
    uci set network.lan.proto='dhcp'
    uci set dhcp.lan.ignore='1'
fi

/etc/init.d/network restart
exit 0
