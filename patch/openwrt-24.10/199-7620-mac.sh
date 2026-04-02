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


# 设置默认防火墙规则，方便虚拟机首次访问 WebUI
#uci set firewall.@zone[1].input='ACCEPT'

# 设置主机名映射，解决安卓原生 TV 无法联网的问题
#uci add dhcp domain
#uci set "dhcp.@domain[-1].name=time.android.com"
#uci set "dhcp.@domain[-1].ip=203.107.6.88"


# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

#其他网络设置
uci del dhcp.lan.ra
uci del dhcp.lan.ra_slaac
uci del dhcp.lan.dns_service
uci del dhcp.lan.ra_flags
uci del network.globals.ula_prefix
uci del dhcp.lan.dhcpv6
uci del dhcp.lan.ndp
uci del network.wan6
uci del network.lan.ip6assign

uci commit dhcp
uci commit network


sed -i '/modem/d' /etc/opkg/distfeeds.conf
sed -i '/Modem/d' /etc/opkg/distfeeds.conf
sed -i '/passwall/d' /etc/opkg/distfeeds.conf
sed -i '/helloworld/d' /etc/opkg/distfeeds.conf
sed -ri '/check_signature/s@^[^#]@#&@' /etc/opkg.conf
sed -i 's#downloads.openwrt.org#mirrors.pku.edu.cn/openwrt#g' /etc/opkg/distfeeds.conf
sed -i '/targets/d' /etc/opkg/distfeeds.conf
sed -i '$a src/gz kmods https://mirrors.pku.edu.cn/openwrt/releases/24.10.6/targets/ramips/mt7620/kmods/6.6.127-1-e156c4be740188c893fc3b1d858df413' /etc/opkg/distfeeds.conf
sed -i '$a src/gz mt7621pkg https://mirrors.pku.edu.cn/openwrt/releases/24.10.6/targets/ramips/mt7620/packages' /etc/opkg/distfeeds.conf

uci set wireless.default_radio0.ssid='WiFi-5G'
uci set wireless.default_radio1.ssid='WiFi-2.4G'
uci set wireless.default_radio0.macaddr='random'
uci set wireless.default_radio1.macaddr='random'
uci add network device
uci set network.@device[-1].name='eth0.2'
uci set network.@device[-1].type='8021q'
uci set network.@device[-1].ifname='eth0'
uci set network.@device[-1].vid='2'
uci set network.@device[-1].macaddr='5e:28:7a:bb:98:68'
chmod +x /etc/mac_ip-change.sh
cat << 'EOF' > /etc/rc.local
sleep 3
bash /etc/mac_ip-change.sh
exit 0
EOF

uci commit wireless
uci commit dhcp
uci commit network
uci commit

/etc/init.d/network restart

exit 0
