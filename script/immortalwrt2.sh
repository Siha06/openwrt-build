sed -i 's/192.168.1.1/192.168.3.99/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.3.99/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/WiFi/g' package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc
sed -i 's#mirrors.vsean.net/openwrt#mirrors.pku.edu.cn/immortalwrt#g' package/emortal/default-settings/files/99-default-settings-chinese
mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner

mv $GITHUB_WORKSPACE/patch/imm21.02/virtualhere/199-mydef.sh package/base-files/files/etc/uci-defaults/199-mydef.sh
mv $GITHUB_WORKSPACE/patch/imm21.02/virtualhere/virtualhere package/base-files/files/etc/virtualhere
mv $GITHUB_WORKSPACE/patch/imm21.02/virtualhere/config.ini package/base-files/files/etc/virtualhere-config.ini
