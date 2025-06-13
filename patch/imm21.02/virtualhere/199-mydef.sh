#!/bin/sh

#uci set wireless.radio0.cell_density=0
uci set wireless.default_radio0.ssid=WDSLR-5G-$(cat /sys/class/ieee80211/phy0/macaddress|awk -F ":" '{print $5""$6 }' | tr 'a-z' 'A-Z')
uci set wireless.default_radio1.ssid=WDSLR-2.4G-$(cat /sys/class/ieee80211/phy0/macaddress|awk -F ":" '{print $5""$6 }' | tr 'a-z' 'A-Z')
uci set wireless.default_radio0.encryption='psk2'
uci set wireless.default_radio0.key='11111111'
uci set wireless.radio0.channel='auto'
uci set wireless.radio1.disabled=1
uci set network.lan.ipaddr='192.168.101.1'
uci set system.cfg01e48a.hostname=DSLR-$(cat /sys/class/ieee80211/phy0/macaddress|awk -F ":" '{print $5""$6 }' | tr 'a-z' 'A-Z')

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

uci commit

sed -i 's/root::0:0:99999:7:::/root:$1$NdH27HBE$dmUpSX8x61asq1ewgkEvz1:20110:0:99999:7:::/g' /etc/shadow
sed -i 's/root:::0:99999:7:::/root:$1$NdH27HBE$dmUpSX8x61asq1ewgkEvz1:20110:0:99999:7:::/g' /etc/shadow

#wget -P /usr/sha/ https://testingcf.jsdelivr.net/gh/HiboyHiboy/opt-file/Advanced_Extensions_virtualhereasp
mv /etc/virtualhere /usr/share/virtualhere
mv /etc/virtualhere-config.ini /usr/share/config.ini
chmod +x /usr/share/virtualhere
echo > /etc/rc.local
sed -i '$a cd /usr/share' /etc/rc.local
sed -i '$a ./virtualhere -b' /etc/rc.local
sed -i '$a exit 0' /etc/rc.local

sed -ri '/check_signature/s@^[^#]@#&@' /etc/opkg.conf

/etc/init.d/network restart
# /etc/init.d/odhcpd restart
# /etc/init.d/rpcd restart
/etc/init.d/system restart

exit 0
