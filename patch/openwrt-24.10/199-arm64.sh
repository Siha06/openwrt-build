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

OPENCLASH_FILE="/etc/config/openclash"
if [ -f "$OPENCLASH_FILE" ]; then
    mv /etc/my-clash /etc/openclash/core/clash_meta
fi

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

#其他网络设置

#uci set network.lan.ip6assign='64'
#uci set network.lan.ip6ifaceid='eui64'
#uci commit network

sed -ri '/check_signature/s@^[^#]@#&@' /etc/opkg.conf
sed -i 's#downloads.openwrt.org#mirrors.pku.edu.cn/openwrt#g' /etc/opkg/distfeeds.conf
sed -i '$a src/gz kmods https://mirrors.pku.edu.cn/openwrt/releases/24.10.1/targets/armsr/armv8/kmods/6.6.86-1-1fbbf4bedbd6cd5ecacfa33e18d228fb' /etc/opkg/customfeeds.conf
sed -i '$a #src/gz kiddin9 https://dl.openwrt.ai/packages-24.10/aarch64_generic/kiddin9' /etc/opkg/customfeeds.conf

# 统计eth接口数量，大于1个则将eth0设为wan其它网口设为lan，只有1个则设置成DHCP模式
eth_count=$(ls /sys/class/net | grep -c '^eth')
if [ $eth_count -gt 1 ]; then
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

uci commit network
uci commit dhcp
uci commit

/etc/init.d/network restart
/etc/init.d/odhcpd restart

exit 0
