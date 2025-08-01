#添加TurboAcc
#curl -sSL https://raw.githubusercontent.com/chenmozhijin/turboacc/luci/add_turboacc.sh -o add_turboacc.sh && bash add_turboacc.sh
sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.23.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
#sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/R5S/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/WiFi/g' package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc
#sed -i 's/ImmortalWrt/WiFi/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
mv $GITHUB_WORKSPACE/patch/imm-24.10/199-rockchip.sh package/base-files/files/etc/uci-defaults/zz-rockchip.sh
mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner

#mv $GITHUB_WORKSPACE/patch/imm-24.10/rc.local package/base-files/files/etc/rc.local
#mv $GITHUB_WORKSPACE/patch/imm-24.10/my-crontabs package/base-files/files/etc/my-crontabs

if grep -q "openclash=y" "$GITHUB_WORKSPACE/$CONFIG_FILE"; then
    git clone --depth 1 -b core https://github.com/vernesong/OpenClash.git  package/openclash-core
    tar -zxf package/openclash-core/master/meta/clash-linux-arm64.tar.gz -C package/base-files/files/etc/
    mv package/base-files/files/etc/clash package/base-files/files/etc/my-clash
    rm -rf package/openclash-core
fi


#完全删除luci版本
sed -i "s/+ ' \/ ' : '') + (luciversion ||/:/g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
#添加编译日期
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/usr/lib/os-release
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/etc/openwrt_release

rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 24.x feeds/packages/lang/golang
git clone --depth 1 https://github.com/vernesong/OpenClash.git package/OpenClash
git clone --depth 1 https://github.com/nikkinikki-org/OpenWrt-nikki.git package/OpenWrt-nikki
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall.git package/passwall
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall2.git package/passwall2
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall-packages.git package/passwall-packages
rm -rf feeds/luci/applications/{luci-app-passwall,luci-app-openclash}
rm -rf feeds/packages/net/{mosdns,v2ray-geodata}
rm -rf feeds/packages/net/{chinadns-ng,dns2socks,geoview,hysteria,ipt2socks,microsocks,naiveproxy,shadowsocks-libev,shadowsocks-rust}
rm -rf feeds/packages/net/{shadowsocksr-libev,simple-obfs,sing-box,tcping,trojan-plus,tuic-client,v2ray-geodata,v2ray-plugin,xray-core,xray-plugin}
#rm -rf feeds/packages/utils/v2dat
#find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
#find ./ | grep Makefile | grep mosdns | xargs rm -f
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

#git clone --depth 1 https://github.com/yichya/luci-app-xray.git package/luci-app-xray
#git clone --depth 1 https://github.com/Thaolga/openwrt-nekobox.git package/openwrt-nekobox
#git clone --depth 1 https://github.com/fcshark-org/openwrt-fchomo.git package/openwrt-fchomo
#git clone --depth 1 https://github.com/Siriling/5G-Modem-Support.git package/5g-modem

# iStore
git clone --depth 1 -b main https://github.com/linkease/istore.git package/istore
git clone --depth 1 -b master https://github.com/linkease/nas-packages.git package/nas-packages
git clone --depth 1 -b main https://github.com/linkease/nas-packages-luci.git package/nas-luci
mv package/nas-packages/network/services/* package/nas-packages/
rm -rf package/nas-packages/network

#git clone --depth 1 -b js https://github.com/sirpdboy/luci-theme-kucat.git package/luci-theme-kucat
#git clone --depth 1 https://github.com/Siha06/my-openwrt-packages.git package/my-openwrt-packages
git clone --depth 1 https://github.com/sirpdboy/luci-app-autotimeset package/luci-app-autotimeset
git clone --depth 1 https://github.com/sirpdboy/luci-app-chatgpt-web.git package/luci-app-chatgpt-web
git clone --depth 1 https://github.com/sirpdboy/luci-app-eqosplus.git package/luci-app-eqosplus
git clone --depth 1 https://github.com/danchexiaoyang/luci-app-kodexplorer.git package/luci-app-kodexplorer
git clone --depth 1 https://github.com/sirpdboy/luci-app-lucky.git package/lucky
git clone --depth 1 https://github.com/sirpdboy/netspeedtest.git package/netspeedtest
git clone --depth 1 https://github.com/destan19/OpenAppFilter.git package/openwrt-oaf
git clone --depth 1 https://github.com/bobbyunknown/luci-app-syscontrol.git package/luci-app-syscontrol
git clone --depth 1 https://github.com/sirpdboy/luci-app-taskplan.git package/luci-app-taskplan
git clone --depth 1 https://github.com/sirpdboy/luci-app-timecontrol.git package/luci-app-timecontrol


#rm -rf feeds/packages/net/adguardhome
git clone --depth 1 https://github.com/kenzok8/small-package.git package/kz8-small
mv package/kz8-small/luci-app-adguardhome package/luci-app-adguardhome
mv package/kz8-small/luci-app-ikoolproxy package/luci-app-ikoolproxy
mv package/kz8-small/luci-app-macvlan package/luci-app-macvlan
mv package/kz8-small/luci-app-partexp package/luci-app-partexp
mv package/kz8-small/luci-app-poweroffdevice package/luci-app-poweroffdevice
mv package/kz8-small/luci-app-wrtbwmon package/luci-app-wrtbwmon
mv package/kz8-small/wrtbwmon package/wrtbwmon
mv package/kz8-small/luci-app-webrestriction package/luci-app-webrestriction
mv package/kz8-small/luci-app-wolplus package/luci-app-wolplus
rm -rf package/kz8-small

#git clone --depth 1 -b openwrt-21.02 https://github.com/immortalwrt/luci.git package/mypkg/imm21-luci
#mv package/mypkg/imm21-luci/applications/luci-app-advancedsetting package/mypkg/luci-app-advancedsetting
#mv package/mypkg/imm21-luci/applications/luci-app-filetransfer package/mypkg/luci-app-filetransfer
#mv package/mypkg/imm21-luci/applications/luci-app-webadmin package/mypkg/luci-app-webadmin
# mv package/mypkg/imm21-luci/applications/luci-app-wireguard package/mypkg/luci-app-wireguard
#mv package/mypkg/imm21-luci/libs/luci-lib-fs package/mypkg/luci-lib-fs
#rm -rf package/mypkg/imm21-luci
#sed -i 's#../../luci.mk#$(TOPDIR)/feeds/luci/luci.mk#g' $(find ./package/mypkg/ -type f -name "Makefile")

#修复TailScale配置文件冲突
sed -i '/\/files/d'  feeds/packages/net/tailscale/Makefile
