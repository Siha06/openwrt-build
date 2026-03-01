sed -i 's/192.168.1.1/10.3.2.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/10.3.2.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
#sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/files/bin/config_generate
#sed -i 's/ImmortalWrt/WiFi/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i 's#mirrors.vsean.net/openwrt#mirrors.pku.edu.cn/immortalwrt#g' package/emortal/default-settings/files/99-default-settings-chinese
mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner

#mv $GITHUB_WORKSPACE/patch/imm21.02/virtualhere/199-mydef.sh package/base-files/files/etc/uci-defaults/199-mydef.sh
#mv $GITHUB_WORKSPACE/patch/imm21.02/virtualhere/virtualhere package/base-files/files/etc/virtualhere
#mv $GITHUB_WORKSPACE/patch/imm21.02/virtualhere/config.ini package/base-files/files/etc/virtualhere-config.ini

#完全删除luci版本
sed -i "s/+ ' \/ ' : '') + (luciversion ||/:/g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
#添加编译日期
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/usr/lib/os-release
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/etc/openwrt_release

rm -rf feeds/packages/net/{adguardhome,smartdns,tailscale}
rm -rf feeds/luci/applications/{luci-app-alist,luci-app-smartdns}
git clone --depth 1 https://github.com/kenzok8/small-package.git package/small-package
mv package/small-package/luci-app-adguardhome package/luci-app-adguardhome
mv package/small-package/adguardhome feeds/packages/net/adguardhome
mv package/small-package/luci-app-easymesh package/luci-app-easymesh
mv package/small-package/luci-app-easytier package/luci-app-easytier
mv package/small-package/easytier package/easytier
mv package/small-package/luci-app-gecoosac package/luci-app-gecoosac
mv package/small-package/luci-app-lucky package/luci-app-lucky
mv package/small-package/lucky package/lucky
mv package/small-package/luci-app-smartdns package/luci-app-smartdns
mv package/small-package/smartdns feeds/packages/net/smartdns
mv package/small-package/luci-app-tailscale package/luci-app-tailscale
mv package/small-package/tailscale feeds/packages/net/tailscale
mv package/small-package/luci-app-ikoolproxy package/luci-app-ikoolproxy
rm -rf package/small-package
