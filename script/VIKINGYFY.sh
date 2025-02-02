# 修改默认IP，主机名
sed -i 's/192.168.1.1/192.168.33.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.33.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/files/bin/config_generate

mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner
mv $GITHUB_WORKSPACE/patch/ipq-vikingyfy/199-mydef.sh package/base-files/files/etc/uci-defaults/199-mydef.sh
#sed -i 's#downloads.immortalwrt.org#mirrors.pku.edu.cn/immortalwrt#g' package/emortal/default-settings/files/99-distfeeds.conf

#默认WiFi设置
sed -i 's/OWRT/OpenWrt-WiFi/g' package/base-files/files/etc/uci-defaults/990_set-wireless.sh
sed -i '/BASE_WORD/d' package/base-files/files/etc/uci-defaults/990_set-wireless.sh
sed -i 's/psk2+ccmp/none/g' package/base-files/files/etc/uci-defaults/990_set-wireless.sh
# sed -i 's/ImmortalWrt/AX1800/g' package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc
# sed -i 's/encryption=none/encryption=psk2/g' package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc
# sed -i '214i\\t\t\tset wireless.default_${name}.key=123456qwerty' package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc


#下载5g模块
git clone --depth=1 https://github.com/Siriling/5G-Modem-Support.git package/5g-modem
sed -i 's/移动通信模组/通信模组/g' package/5g-modem/luci-app-modem/po/zh-cn/modem.po
sed -i 's/移动通信模组/通信模组/g' package/5g-modem/luci-app-modem/po/zh_Hans/modem.po
sed -i 's/\"network\"/\"modem\"/g' package/5g-modem/luci-app-modem/luasrc/controller/modem.lua
rm -rf feeds/packages/net/quectel-cm
rm -rf feeds/packages/kernel/fibocom-qmi-wwan
rm -rf feeds/packages/kernel/quectel-qmi-wwan
rm -rf feeds/luci/protocols/luci-proto-quectel
rm -rf feeds/nss_packages/wwan

#rm -rf feeds/packages/lang/ruby
#git clone --depth=1 -b openwrt-23.05 --single-branch https://github.com/immortalwrt/packages.git package/immortal-pkg
#mv package/immortal-pkg/lang/ruby feeds/packages/lang/ruby
#rm -rf package/immortal-pkg

# iStore
git clone --depth=1 -b main https://github.com/linkease/istore.git package/istore
git clone --depth=1 -b master https://github.com/linkease/nas-packages.git package/nas-packages
git clone --depth=1 -b main https://github.com/linkease/nas-packages-luci.git package/nas-luci
mv package/nas-packages/network/services/* package/nas-packages/
rm -rf package/nas-packages/network

git clone --depth=1 https://github.com/sirpdboy/luci-app-advancedplus.git package/luci-app-advancedplus
git clone --depth=1 https://github.com/kenzok8/small-package.git package/kz8-small
mv package/kz8-small/luci-app-adguardhome package/luci-app-adguardhome
mv package/kz8-small/luci-app-easymesh package/luci-app-easymesh
mv package/kz8-small/luci-app-fileassistant package/luci-app-fileassistant
mv package/kz8-small/luci-app-ikoolproxy package/luci-app-ikoolproxy
mv package/kz8-small/luci-app-macvlan package/luci-app-macvlan
mv package/kz8-small/luci-app-partexp package/luci-app-partexp
mv package/kz8-small/luci-app-wrtbwmon package/luci-app-wrtbwmon
mv package/kz8-small/wrtbwmon package/wrtbwmon
rm -rf package/kz8-small

chmod +x package/emortal/luci-app-athena-led/root/etc/init.d/athena_led 
chmod +x package/emortal/luci-app-athena-led/root/usr/sbin/athena-led
