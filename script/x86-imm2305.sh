sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.23.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/ImmortalWrt/X86/g' package/base-files/files/bin/config_generate
sed -i 's#mirrors.vsean.net/openwrt#mirror.nju.edu.cn/immortalwrt#g' package/emortal/default-settings/files/99-default-settings-chinese
mv $GITHUB_WORKSPACE/patch/banner $OPENWRT_PATH/package/base-files/files/etc/banner
mv $GITHUB_WORKSPACE/patch/imm23/defset $OPENWRT_PATH/package/emortal/default-settings/files/99-default-settings

#git clone --depth=1 https://github.com/asvow/luci-app-tailscale.git package/luci-app-tailscale
git clone --depth=1 https://github.com/Siriling/5G-Modem-Support.git package/5g-modem
sed -i 's/移动通信模组/通信模组/g' package/5g-modem/luci-app-modem/po/zh-cn/modem.po
sed -i 's/移动通信模组/通信模组/g' package/5g-modem/luci-app-modem/po/zh_Hans/modem.po

rm -rf feeds/packages/lang/golang
git clone --depth=1 https://github.com/sbwml/packages_lang_golang -b 23.x feeds/packages/lang/golang
#git clone --depth=1 https://github.com/fw876/helloworld.git package/helloworld
#git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall2.git package/passwall2
#git clone --depth=1 https://github.com/gdy666/luci-app-lucky.git package/lucky
#git clone --depth=1 https://github.com/kiddin9/openwrt-clouddrive2.git package/openwrt-clouddrive2
#git clone --depth=1 https://github.com/morytyann/OpenWrt-mihomo.git package/mihomo

git clone --depth=1 https://github.com/kenzok8/small-package.git package/small-package
mv package/small-package/luci-app-adguardhome package/luci-app-adguardhome
#mv package/small-package/adguardhome package/adguardhome
mv package/small-package/luci-app-netspeedtest package/luci-app-netspeedtest
mv package/small-package/homebox package/homebox
rm -rf package/small-package

# iStore
git clone --depth=1 -b main https://github.com/linkease/istore.git package/istore
git clone --depth=1 -b master https://github.com/linkease/nas-packages.git package/nas-packages
git clone --depth=1 -b main https://github.com/linkease/nas-packages-luci.git package/nas-luci
mv package/nas-packages/network/services/* package/nas-packages/
rm -rf package/nas-packages/network
