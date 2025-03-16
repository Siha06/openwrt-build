# 修改默认IP，主机名
sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.23.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/LibWrt/OpenWrt/g' package/base-files/files/bin/config_generate
sed -i 's/LiBwrt/OpenWrt/g' include/version.mk
mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner

#完全删除luci版本
sed -i "s/+ ' \/ ' : '') + (luciversion ||/:/g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
#添加编译日期
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/usr/lib/os-release
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/etc/openwrt_release

# sed -i 's/LiBwrt/OpenWrt/g' package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc
mv $GITHUB_WORKSPACE/patch/ipq-breeze/mac80211.uc package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc
mv $GITHUB_WORKSPACE/patch/ipq-breeze/199-mydef.sh package/base-files/files/etc/uci-defaults/199-mydef.sh
sed -i 's#downloads.immortalwrt.org#mirrors.pku.edu.cn/immortalwrt#g' package/emortal/default-settings/files/99-distfeeds.conf
git clone --depth 1 -b core https://github.com/vernesong/OpenClash.git  package/openclash-core
mv package/openclash-core/master/meta/clash-linux-arm64.tar.gz package/base-files/files/etc/clash-linux-arm64.tar.gz
rm -rf package/openclash-core

#下载5g模块
git clone --depth=1 https://github.com/Siriling/5G-Modem-Support.git package/5g-modem
sed -i '/pcie_mhi/d' package/5g-modem/luci-app-modem/Makefile
#sed -i 's/移动通信模组/通信模组/g' package/5g-modem/luci-app-modem/po/zh-cn/modem.po
#sed -i 's/移动通信模组/通信模组/g' package/5g-modem/luci-app-modem/po/zh_Hans/modem.po
#mv $GITHUB_WORKSPACE/patch/modem.lua $OPENWRT_PATH/package/5g-modem/luci-app-modem/luasrc/controller/modem.lua
rm -rf feeds/packages/net/quectel-cm
rm -rf feeds/packages/kernel/fibocom-qmi-wwan
rm -rf feeds/packages/kernel/quectel-qmi-wwan
rm -rf feeds/luci/protocols/luci-proto-quectel
rm -rf feeds/nss_packages/wwan

# iStore
git clone --depth=1 -b main https://github.com/linkease/istore.git package/istore
git clone --depth=1 -b master https://github.com/linkease/nas-packages.git package/nas-packages
git clone --depth=1 -b main https://github.com/linkease/nas-packages-luci.git package/nas-luci
mv package/nas-packages/network/services/* package/nas-packages/
rm -rf package/nas-packages/network

git clone --depth 1 https://github.com/vernesong/OpenClash.git package/OpenClash
git clone --depth 1 https://github.com/morytyann/OpenWrt-mihomo.git package/mihomo
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall.git package/passwall
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall2.git package/passwall2
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall-packages.git package/passwall-packages
rm -rf feeds/packages/devel/gn
rm -rf feeds/luci/applications/{luci-app-passwall,luci-app-openclash}

#find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
#find ./ | grep Makefile | grep mosdns | xargs rm -f
rm -rf feeds/packages/net/v2ray-geodata
rm -rf feeds/packages/net/mosdns
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

rm -rf feeds/packages/net/adguardhome
#git clone --depth 1 https://github.com/jarod360/luci-app-xupnpd.git package/luci-app-xupnpd
git clone --depth 1 https://github.com/kenzok8/small-package.git package/kz8-small
mv package/kz8-small/adguardhome package/adguardhome
mv package/kz8-small/luci-app-adguardhome package/luci-app-adguardhome
mv package/kz8-small/luci-app-ikoolproxy package/luci-app-ikoolproxy
mv package/kz8-small/luci-app-macvlan package/luci-app-macvlan
mv package/kz8-small/luci-app-partexp package/luci-app-partexp
mv package/kz8-small/luci-app-wrtbwmon package/luci-app-wrtbwmon
mv package/kz8-small/wrtbwmon package/wrtbwmon
mv package/kz8-small/luci-app-webrestriction package/luci-app-webrestriction
rm -rf package/kz8-small

git clone --depth 1 -b openwrt-23.05 https://github.com/coolsnowwolf/luci.git package/lean-luci23
mv package/lean-luci23/applications/luci-app-accesscontrol package/luci-app-accesscontrol
sed -i 's#../../luci.mk#$(TOPDIR)/feeds/luci/luci.mk#g' package/luci-app-accesscontrol/Makefile
rm -rf package/lean-luci23

#mv $GITHUB_WORKSPACE/patch/ipq-breeze/os-release package/base-files/files/usr/lib/os-release
#mv $GITHUB_WORKSPACE/patch/ipq-breeze/10_system.js feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
# sed -i '214i\\t\t\tset wireless.default_${name}.key=123456qwerty' package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc
#sed -i 's/24.10/23.05/g' package/emortal/default-settings/files/99-distfeeds.conf
