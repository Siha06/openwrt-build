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

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''


#uci set luci.main.mediaurlbase=/luci-static/infinityfreedom
#uci commit luci

uci commit

sed -i '/passwall/d' /etc/opkg/distfeeds.conf
sed -ri '/check_signature/s@^[^#]@#&@' /etc/opkg.conf
sed -i 's#downloads.openwrt.org#mirrors.pku.edu.cn/openwrt#g' /etc/opkg/distfeeds.conf
sed -i '/targets/d' /etc/opkg/distfeeds.conf

sed -i '$a src/gz kmods https://mirror.nju.edu.cn/openwrt/releases/22.03.7/targets/x86/64/kmods/5.10.221-1-bb372724df40051c0f132fa20fc778d0' /etc/opkg/distfeeds.conf
sed -i '$a src/gz others https://mirror.nju.edu.cn/openwrt/releases/22.03.7/targets/x86/64/packages' /etc/opkg/distfeeds.conf


cp /etc/my-clash /etc/openclash/core/clash_meta



uci commit dhcp
uci commit network
uci commit
/etc/init.d/network restart

exit 0
