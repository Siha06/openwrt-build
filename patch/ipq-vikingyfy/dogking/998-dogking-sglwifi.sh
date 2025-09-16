#!/bin/sh

sed -i '/passwall/d' /etc/apk/repositories.d/distfeeds.list
sed -i '/nss/d' /etc/apk/repositories.d/distfeeds.list
sed -i '/sqm/d' /etc/apk/repositories.d/distfeeds.list
sed -i '/qualcommax/d' /etc/apk/repositories.d/distfeeds.list
sed -i 's#downloads.immortalwrt.org#mirrors.pku.edu.cn/immortalwrt#g' /etc/apk/repositories.d/distfeeds.list
sed -i '$a https://mirrors.pku.edu.cn/immortalwrt/snapshots/targets/qualcommax/ipq60xx/kmods/6.12.44-1-a6f9a9cd3032604645b5df27b24dcf61/packages.adb' /etc/apk/repositories.d/distfeeds.list
sed -i '$a https://mirrors.pku.edu.cn/immortalwrt/snapshots/targets/qualcommax/ipq60xx/packages/packages.adb' /etc/apk/repositories.d/distfeeds.list

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

cp /etc/my-clash /etc/openclash/core/clash_meta
cat /diy4me/rules-pw2 >> /etc/config/passwall2
cat << EOF > /etc/config/ddnsto
config ddnsto
	option enabled '1'
	option feat_port '3033'
	option feat_enabled '0'
	option index '1'
	option token '18b8b805-1147-40dd-a4c5-94b05206138b'
EOF
/etc/init.d/ddnsto restart

# 10–11 192.168.1.10/31  
# 12–15 192.168.1.12/30   
# 16–31 192.168.1.16/28   
# 32–63 192.168.1.32/27   
# 64–95 192.168.1.64/27   

uci add firewall rule
uci set firewall.@rule[-1].src='lan'
uci add_list firewall.@rule[-1].src_ip='10.5.1.16/28'
uci add_list firewall.@rule[-1].src_ip='10.5.1.32/27'
uci add_list firewall.@rule[-1].src_ip='10.5.1.64/27'
uci set firewall.@rule[-1].dest='wan'
uci set firewall.@rule[-1].name="ban"
uci add_list firewall.@rule[-1].proto='all'
uci set firewall.@rule[-1].target='REJECT'
# uci set firewall.@rule[-1].enabled='0'
uci commit

uci set dhcp.lan.start='20'
uci set dhcp.lan.limit='70'
uci set wireless.default_radio0.ssid=OpenWrt-$(cat /sys/class/ieee80211/phy0/macaddress|awk -F ":" '{print $5""$6 }' | tr 'a-z' 'A-Z')-5G1
uci set wireless.default_radio1.ssid=OpenWrt-$(cat /sys/class/ieee80211/phy0/macaddress|awk -F ":" '{print $5""$6 }' | tr 'a-z' 'A-Z')-2.4G
uci set wireless.default_radio2.ssid=OpenWrt-$(cat /sys/class/ieee80211/phy0/macaddress|awk -F ":" '{print $5""$6 }' | tr 'a-z' 'A-Z')-5G2
uci commit wireless
uci commit

exit 0
