sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.23.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
mv $GITHUB_WORKSPACE/patch/openwrt-24.10/199-x86.sh package/base-files/files/etc/uci-defaults/199-x86.sh


#添加编译日期
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/usr/lib/os-release
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/etc/openwrt_release

git clone --depth 1 https://github.com/Siriling/5G-Modem-Support.git package/5g-modem
#sed -i 's/移动通信模组/通信模组/g' package/5g-modem/luci-app-modem/po/zh-cn/modem.po
#sed -i 's/移动通信模组/通信模组/g' package/5g-modem/luci-app-modem/po/zh_Hans/modem.po

# iStore
git clone --depth 1 -b main https://github.com/linkease/istore.git package/istore
git clone --depth 1 -b master https://github.com/linkease/nas-packages.git package/nas-packages
git clone --depth 1 -b main https://github.com/linkease/nas-packages-luci.git package/nas-luci
mv package/nas-packages/network/services/* package/nas-packages/
rm -rf package/nas-packages/network

rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 23.x feeds/packages/lang/golang
find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
find ./ | grep Makefile | grep mosdns | xargs rm -f
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata
git clone --depth 1 https://github.com/fw876/helloworld.git package/helloworld
git clone --depth 1 https://github.com/vernesong/OpenClash.git  package/openclash
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall-packages.git package/passwall-packages
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall.git package/luci-app-passwall
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall2.git package/luci-app-passwall2
git clone --depth 1 https://github.com/morytyann/OpenWrt-mihomo.git package/OpenWrt-mihomo

git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
#git clone --depth 1 https://github.com/sirpdboy/luci-app-advancedplus package/luci-app-advancedplus
git clone --depth 1 https://github.com/sirpdboy/luci-app-autotimeset package/luci-app-autotimeset
git clone --depth 1 https://github.com/sirpdboy/luci-app-chatgpt-web.git package/luci-app-chatgpt-web
git clone --depth 1 https://github.com/sirpdboy/luci-app-ddns-go.git package/luci-app-ddns-go
git clone --depth 1 https://github.com/sirpdboy/netspeedtest.git package/netspeedtest
git clone --depth 1 https://github.com/destan19/OpenAppFilter.git package/openwrt-oaf

git clone --depth 1 -b openwrt-24.10 https://github.com/immortalwrt/luci.git package/mypkg/imm24-luci
mv package/mypkg/imm24-luci/applications/luci-app-autoreboot package/mypkg/luci-app-autoreboot
mv package/mypkg/imm24-luci/applications/luci-app-diskman package/mypkg/luci-app-diskman
mv package/mypkg/imm24-luci/applications/luci-app-homeproxy package/mypkg/luci-app-homeproxy
mv package/mypkg/imm24-luci/applications/luci-app-ramfree package/mypkg/luci-app-ramfree
mv package/mypkg/imm24-luci/applications/luci-app-syncdial package/mypkg/luci-app-syncdial
#rm -rf feeds/luci/modules
#mv package/mypkg/imm24-luci/modules feeds/luci/modules
rm -rf package/mypkg/imm24-luci
sed -i 's#../../luci.mk#$(TOPDIR)/feeds/luci/luci.mk#g' $(find ./package/mypkg/ -type f -name "Makefile")

#完全删除luci版本
sed -i "s/+ ' \/ ' : '') + (luciversion ||/:/g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js

rm -rf feeds/packages/net/adguardhome
git clone --depth=1 https://github.com/kenzok8/small-package.git package/kz8-small
mv package/kz8-small/adguardhome package/adguardhome
mv package/kz8-small/luci-app-adguardhome package/luci-app-adguardhome
mv package/kz8-small/luci-app-ikoolproxy package/luci-app-ikoolproxy
mv package/kz8-small/luci-app-partexp package/luci-app-partexp
mv package/kz8-small/luci-app-wrtbwmon package/luci-app-wrtbwmon
mv package/kz8-small/wrtbwmon package/wrtbwmon
mv package/kz8-small/luci-app-poweroff package/luci-app-poweroff
rm -rf package/kz8-small
