#!/bin/sh

# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

uci commit

sed -ri '/check_signature/s@^[^#]@#&@' /etc/opkg.conf


cp /etc/my-clash /etc/openclash/core/clash_meta
mv /etc/bw-index.htm /usr/lib/lua/luci/view/admin_status/index.htm

sed -i '/UA2F/d' /etc/opkg/distfeeds.conf
sed -i '/ua2f/d' /etc/opkg/distfeeds.conf
sed -i '/passwall/d' /etc/opkg/distfeeds.conf
sed -i '/core/d' /etc/opkg/distfeeds.conf

sed -i 's/192.168.1.1/192.168.5.1/g' /etc/wireless/mt7615/mt7615.1.5G.dat
sed -i 's/Openwrt_5G/TikTok-5G/g' /etc/wireless/mt7615/mt7615.1.5G.dat
#sed -i 's/Openwrt_5G/XiaoYuan-5G/g' /etc/wireless/mt7615/mt7615.1.5G.dat
sed -i 's/12345678/password/g' /etc/wireless/mt7615/mt7615.1.5G.dat
sed -i 's/AuthMode=OPEN/AuthMode=WPA2PSK/g' /etc/wireless/mt7615/mt7615.1.5G.dat
sed -i 's/EncrypType=NONE/EncrypType=AES/g' /etc/wireless/mt7615/mt7615.1.5G.dat
#sed -i 's/CountryCode=US/CountryCode=RU/g' /etc/wireless/mt7615/mt7615.1.5G.dat

sed -i 's/192.168.1.1/192.168.5.1/g' /etc/wireless/mt7615/mt7615.1.2G.dat
sed -i 's/CR660X_2.4G/TikTok-2.4G/g' /etc/wireless/mt7615/mt7615.1.2G.dat
sed -i 's/12345678/password/g' /etc/wireless/mt7615/mt7615.1.2G.dat
sed -i 's/AuthMode=OPEN/AuthMode=WPA2PSK/g' /etc/wireless/mt7615/mt7615.1.2G.dat
sed -i 's/EncrypType=NONE/EncrypType=AES/g' /etc/wireless/mt7615/mt7615.1.2G.dat
#sed -i 's/CountryCode=US/CountryCode=RU/g' /etc/wireless/mt7615/mt7615.1.2G.dat

/etc/init.d/network restart

exit 0
