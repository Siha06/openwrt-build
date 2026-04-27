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


sed -i '/passwall/d' /etc/apk/repositories.d/distfeeds.list
sed -i '/helloworld/d' /etc/apk/repositories.d/distfeeds.list
sed -i '/modem/d' /etc/apk/repositories.d/distfeeds.list
sed -i '/Modem/d' /etc/apk/repositories.d/distfeeds.list
sed -i '/video/d' /etc/apk/repositories.d/distfeeds.list
sed -i '/targets/d' /etc/apk/repositories.d/distfeeds.list
sed -i 's#downloads.openwrt.org#mirrors.pku.edu.cn/openwrt#g' /etc/apk/repositories.d/distfeeds.list
sed -i '$a https://mirrors.pku.edu.cn/openwrt/releases/25.12.2/targets/rockchip/armv8/kmods/6.12.74-1-e30f543625695988fdad1ed84a7518c2/packages.adb' /etc/apk/repositories.d/distfeeds.list
sed -i '$a https://mirrors.pku.edu.cn/openwrt/releases/25.12.2/targets/rockchip/armv8/packages/packages.adb' /etc/apk/repositories.d/distfeeds.list


#uci set network.USB=interface
#uci set network.USB.proto='dhcp'
#uci set network.USB.device='usb0'
#uci commit network
uci commit

/etc/init.d/network restart

exit 0
