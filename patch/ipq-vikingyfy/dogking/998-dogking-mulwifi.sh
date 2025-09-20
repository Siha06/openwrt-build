#!/bin/sh

sed -i '/passwall/d' /etc/apk/repositories.d/distfeeds.list
sed -i '/nss/d' /etc/apk/repositories.d/distfeeds.list
sed -i '/sqm/d' /etc/apk/repositories.d/distfeeds.list
sed -i '/qualcommax/d' /etc/apk/repositories.d/distfeeds.list
sed -i 's#downloads.immortalwrt.org#mirrors.pku.edu.cn/immortalwrt#g' /etc/apk/repositories.d/distfeeds.list
sed -i '$a https://mirrors.pku.edu.cn/immortalwrt/snapshots/targets/qualcommax/ipq60xx/kmods/6.12.47-1-09d6199d49cb40621ed6a6c8f9567f37/packages.adb' /etc/apk/repositories.d/distfeeds.list
sed -i '$a https://mirrors.pku.edu.cn/immortalwrt/snapshots/targets/qualcommax/ipq60xx/packages/packages.adb' /etc/apk/repositories.d/distfeeds.list

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

cp /etc/my-clash /etc/openclash/core/clash_meta
cat /diy4me/rules-pw2 >> /usr/share/passwall2/0_default_config
cat << EOF > /etc/config/ddnsto
config ddnsto
	option enabled '1'
	option feat_port '3033'
	option feat_enabled '0'
	option index '1'
	option token '18b8b805-1147-40dd-a4c5-94b05206138b'
EOF
/etc/init.d/ddnsto restart

uci del wireless.default_radio0
uci del wireless.default_radio1
uci del wireless.default_radio2
uci commit


############################### 分 割 线 ###################################

# WiFi名称
ssid=OpenWrt
# WiFi密码
password=123456789
# WiFi地址
ipaddr=10.10.101.1


a=$(echo "$ipaddr" | awk -F. '{print $1}')
b=$(echo "$ipaddr" | awk -F. '{print $2}')
c=$(echo "$ipaddr" | awk -F. '{print $3}')
d=$(echo "$ipaddr" | awk -F. '{print $4}')

uci add firewall zone
uci set firewall.@zone[-1].name="proxy"
uci set firewall.@zone[-1].input='ACCEPT'
uci set firewall.@zone[-1].output='ACCEPT'
uci set firewall.@zone[-1].forward='ACCEPT'
uci add firewall forwarding
uci set firewall.@forwarding[-1].src="proxy"
uci set firewall.@forwarding[-1].dest='wan'
uci add firewall rule
uci set firewall.@rule[-1].src="proxy"
uci set firewall.@rule[-1].dest='wan'
uci set firewall.@rule[-1].name="ban-local"
uci add_list firewall.@rule[-1].proto='all'
uci set firewall.@rule[-1].target='REJECT'
uci set firewall.@rule[-1].enabled='0'

# 生成配置
for i in $(seq 1 24); do
    wifinet_num=$((i - 1))
    new_c=$((c + i -1))
	ipaddr="${a}.${b}.${new_c}.${d}"

    # 格式化接口编号为两位数
    wifi_id=$(printf "%02d" $i)

    # 根据序号选择wireless设备
    if [ $i -le 8 ]; then
        wireless_dev="radio0"
		network_dev="5G1AP"
    elif [ "$i" -le 16 ]; then
        wireless_dev="radio2"
		network_dev="5G2AP"
    else
        wireless_dev="radio1"
		network_dev="2.4GAP"
    fi

    # 配置无线接口
    uci set wireless.wifinet${wifinet_num}=wifi-iface
    uci set wireless.wifinet${wifinet_num}.device="$wireless_dev"
    uci set wireless.wifinet${wifinet_num}.mode='ap'
    uci set wireless.wifinet${wifinet_num}.ssid="${ssid}-${wifi_id}"
    uci set wireless.wifinet${wifinet_num}.encryption='psk2+ccmp'
    uci set wireless.wifinet${wifinet_num}.key="$password"
    uci set wireless.wifinet${wifinet_num}.ifname="${network_dev}${wifi_id}"
    uci set wireless.wifinet${wifinet_num}.network="wifi${wifi_id}"

    # 配置网络接口
    uci set network.wifi${wifi_id}=interface
    uci set network.wifi${wifi_id}.proto='static'
    uci set network.wifi${wifi_id}.device="${network_dev}${wifi_id}"
    uci set network.wifi${wifi_id}.ipaddr="$ipaddr"
    uci set network.wifi${wifi_id}.netmask='255.255.255.0'

    # 配置DHCP
    uci set dhcp.wifi${wifi_id}=dhcp
    uci set dhcp.wifi${wifi_id}.interface="wifi${wifi_id}"

    # 配置防火墙
    uci add_list firewall.@zone[-1].network="wifi${wifi_id}"
done

# 提交配置

uci set wireless.radio0.channel='149'
uci set wireless.radio1.channel='11'
uci set wireless.radio2.channel='44'
uci set wireless.radio0.cell_density='0'
uci set wireless.radio1.cell_density='0'
uci set wireless.radio2.cell_density='0'

uci commit wireless
uci commit network
uci commit dhcp
uci commit firewall
uci commit 

exit 0
