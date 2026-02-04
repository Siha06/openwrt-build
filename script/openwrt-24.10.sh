#添加TurboAcc
#curl -sSL https://raw.githubusercontent.com/chenmozhijin/turboacc/luci/add_turboacc.sh -o add_turboacc.sh && bash add_turboacc.sh
sed -i 's/192.168.1.1/10.3.2.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/10.3.2.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/disabled='"'"'\${defaults ? 0 : 1}'"'"'/disabled=0/g' package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc
mv $GITHUB_WORKSPACE/patch/openwrt-24.10/199-7621.sh package/base-files/files/etc/uci-defaults/199-7621.sh
#mv $GITHUB_WORKSPACE/patch/openwrt-24.10/199-rockchip.sh package/base-files/files/etc/uci-defaults/199-rockchip.sh

#rock3b
sed -i 's/RK_PB7 GPIO_ACTIVE_LOW/RK_PB321 GPIO_ACTIVE_LOW/g' target/linux/rockchip/patches-6.6/014-v6.11-arm64-dts-rockchip-Add-Radxa-ROCK-3B.patch
sed -i 's/RK_PB0 GPIO_ACTIVE_LOW/RK_PB7 GPIO_ACTIVE_LOW/g' target/linux/rockchip/patches-6.6/014-v6.11-arm64-dts-rockchip-Add-Radxa-ROCK-3B.patch
sed -i 's/RK_PB321 GPIO_ACTIVE_LOW/RK_PB0 GPIO_ACTIVE_LOW/g' target/linux/rockchip/patches-6.6/014-v6.11-arm64-dts-rockchip-Add-Radxa-ROCK-3B.patch

# mipsle-softfloat
if grep -q "openclash=y" "$GITHUB_WORKSPACE/$CONFIG_FILE"; then
    echo "✅ 已选择 luci-app-openclash，添加 openclash core"
    mkdir -p files/etc/openclash/core
    # Download clash_meta
    META_URL="https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-mipsle-softfloat.tar.gz"
    wget -qO- $META_URL | tar xOvz > files/etc/openclash/core/clash_meta
    chmod +x files/etc/openclash/core/clash_meta
    # 下载 GeoIP 和 GeoSite
    # wget -q https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat -O files/etc/openclash/GeoIP.dat
    # wget -q https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat -O files/etc/openclash/GeoSite.dat
else
    echo "⚪️ 未选择 luci-app-openclash"
fi

#完全删除luci版本
sed -i "s/+ ' \/ ' : '') + (luciversion ||/:/g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
#添加编译日期
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/usr/lib/os-release
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/etc/openwrt_release

rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 25.x feeds/packages/lang/golang

git clone --depth 1 https://github.com/vernesong/OpenClash.git  package/openclash
git clone --depth 1 https://github.com/Openwrt-Passwall/openwrt-passwall package/luci-app-passwall
git clone --depth 1 https://github.com/Openwrt-Passwall/openwrt-passwall2 package/luci-app-passwall2

#git clone --depth 1 https://github.com/Siriling/5G-Modem-Support.git package/5g-modem
#sed -i 's/移动通信模组/通信模组/g' package/5g-modem/luci-app-modem/po/zh-cn/modem.po
#sed -i 's/移动通信模组/通信模组/g' package/5g-modem/luci-app-modem/po/zh_Hans/modem.po
#mv $GITHUB_WORKSPACE/patch/mhi_qti.c package/5g-modem/quectel_MHI/src/controllers/mhi_qti.c

# iStore
git clone --depth 1 -b main https://github.com/linkease/istore.git package/istore
git clone --depth 1 -b master https://github.com/linkease/nas-packages.git package/nas-packages
git clone --depth 1 -b main https://github.com/linkease/nas-packages-luci.git package/nas-luci
mv package/nas-packages/network/services/* package/nas-packages/
rm -rf package/nas-packages/network

git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone --depth 1 https://github.com/sirpdboy/luci-theme-kucat.git package/luci-theme-kucat
git clone --depth 1 https://github.com/Siha06/my-openwrt-packages.git package/my-openwrt-packages
git clone --depth 1 https://github.com/bobbyunknown/luci-app-syscontrol.git package/luci-app-syscontrol
git clone --depth 1 https://github.com/sirpdboy/luci-app-autotimeset package/luci-app-autotimeset
git clone --depth 1 https://github.com/sirpdboy/luci-app-chatgpt-web.git package/luci-app-chatgpt-web
git clone --depth 1 https://github.com/sirpdboy/luci-app-ddns-go.git package/luci-app-ddns-go
git clone --depth 1 https://github.com/sirpdboy/luci-app-eqosplus package/luci-app-eqosplus
git clone --depth 1 https://github.com/destan19/fros-packages-openwrt.git package/fros
git clone --depth 1 https://github.com/sirpdboy/netspeedtest.git package/netspeedtest
git clone --depth 1 https://github.com/destan19/OpenAppFilter.git package/openwrt-oaf
#git clone --depth 1 https://github.com/Diciya/luci-app-broadbandacc.git package/broadbandacc
#git clone --depth 1 https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git package/unblockneteasemusic

git clone --depth 1 -b openwrt-24.10 https://github.com/immortalwrt/luci.git package/mypkg/imm24-luci
mv package/mypkg/imm24-luci/applications/luci-app-autoreboot package/mypkg/luci-app-autoreboot
mv package/mypkg/imm24-luci/applications/luci-app-cpufreq package/mypkg/luci-app-cpufreq
mv package/mypkg/imm24-luci/applications/luci-app-diskman package/mypkg/luci-app-diskman
mv package/mypkg/imm24-luci/applications/luci-app-homeproxy package/mypkg/luci-app-homeproxy
mv package/mypkg/imm24-luci/applications/luci-app-ramfree package/mypkg/luci-app-ramfree
mv package/mypkg/imm24-luci/applications/luci-app-zerotier package/mypkg/luci-app-zerotier
rm -rf feeds/luci/modules
mv package/mypkg/imm24-luci/modules feeds/luci/modules
rm -rf package/mypkg/imm24-luci
sed -i 's#../../luci.mk#$(TOPDIR)/feeds/luci/luci.mk#g' $(find ./package/mypkg/ -type f -name "Makefile")
#完全删除luci版本
sed -i "s/+ ' \/ ' : '') + (luciversion ||/:/g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js

rm -rf feeds/packages/net/adguardhome
git clone --depth 1 https://github.com/kenzok8/small-package.git package/kz8-small
mv package/kz8-small/adguardhome package/adguardhome
mv package/kz8-small/luci-app-adguardhome package/luci-app-adguardhome
mv package/kz8-small/baidupcs-web package/baidupcs-web
mv package/kz8-small/luci-app-baidupcs-web package/luci-app-baidupcs-web
mv package/kz8-small/luci-app-ikoolproxy package/luci-app-ikoolproxy
mv package/kz8-small/luci-app-macvlan package/luci-app-macvlan
mv package/kz8-small/luci-app-partexp package/luci-app-partexp
mv package/kz8-small/luci-app-socat package/luci-app-socat
mv package/kz8-small/luci-app-wrtbwmon package/luci-app-wrtbwmon
mv package/kz8-small/wrtbwmon package/wrtbwmon
mv package/kz8-small/luci-app-webrestriction package/luci-app-webrestriction
mv package/kz8-small/luci-app-wechatpush package/luci-app-wechatpush
mv package/kz8-small/luci-app-wolplus package/luci-app-wolplus
rm -rf package/kz8-small

