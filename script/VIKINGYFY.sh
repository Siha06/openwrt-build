# 修改默认IP，主机名
sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.23.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/OpenWrt/g' include/version.mk
#rust报错
rm -rf feeds/packages/lang/rust
git clone --depth 1 -b openwrt-24.10 https://github.com/immortalwrt/packages.git package/imm24-packages
mv package/imm24-packages/lang/rust feeds/packages/lang/rust
rm -rf package/imm24-packages

mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner
#mv $GITHUB_WORKSPACE/patch/ipq-vikingyfy/998-ipq.sh package/base-files/files/etc/uci-defaults/998-ipq60xx.sh
mv $GITHUB_WORKSPACE/patch/ipq-vikingyfy/998-ipq60xx.sh package/base-files/files/etc/uci-defaults/998-ipq60xx.sh
#mv $GITHUB_WORKSPACE/patch/ipq-vikingyfy/998-ipq807x.sh package/base-files/files/etc/uci-defaults/998-ipq807x.sh

if grep -q "openclash=y" "$GITHUB_WORKSPACE/$CONFIG_FILE"; then
    git clone --depth 1 -b core https://github.com/vernesong/OpenClash.git  package/openclash-core
    tar -zxf package/openclash-core/master/meta/clash-linux-arm64.tar.gz -C package/base-files/files/etc/
    mv package/base-files/files/etc/clash package/base-files/files/etc/my-clash
    rm -rf package/openclash-core
fi

# iStore
git clone --depth=1 -b main https://github.com/linkease/istore.git package/istore
git clone --depth=1 -b master https://github.com/linkease/nas-packages.git package/nas-packages
git clone --depth=1 -b main https://github.com/linkease/nas-packages-luci.git package/nas-luci
mv package/nas-packages/network/services/* package/nas-packages/
rm -rf package/nas-packages/network

#完全删除luci版本
#sed -i "s/+ ' \/ ' : '') + (luciversion ||/:/g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
#添加编译日期
#sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/usr/lib/os-release
#sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/etc/openwrt_release

#默认WiFi设置
sed -i 's/OWRT/WiFi/g' target/linux/qualcommax/base-files/etc/uci-defaults/990_set-wireless.sh
sed -i 's/12345678/password/g' target/linux/qualcommax/base-files/etc/uci-defaults/990_set-wireless.sh
#sed -i '/BASE_WORD/d' target/linux/qualcommax/base-files/etc/uci-defaults/990_set-wireless.sh
#sed -i 's/psk2+ccmp/none/g' target/linux/qualcommax/base-files/etc/uci-defaults/990_set-wireless.sh

sed -i 's/hybrid/server/g' target/linux/qualcommax/base-files/etc/uci-defaults/991_set-network.sh

#下载5g模块
git clone --depth=1 https://github.com/Siriling/5G-Modem-Support.git package/5g-modem
#rm -rf feeds/packages/net/quectel-cm
#rm -rf feeds/packages/kernel/fibocom-qmi-wwan
#rm -rf feeds/packages/kernel/quectel-qmi-wwan
#rm -rf feeds/luci/protocols/luci-proto-quectel
#rm -rf feeds/nss_packages/wwan

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

git clone --depth 1 https://github.com/destan19/OpenAppFilter.git  package/oaf
git clone --depth 1 https://github.com/kiddin9/kwrt-packages.git package/kwrt-packages
#mv package/kwrt-packages/uugamebooster package/uugamebooster
#mv package/kwrt-packages/luci-app-uugamebooster package/luci-app-uugamebooster
mv package/kwrt-packages/luci-app-pushbot package/luci-app-pushbot
rm -rf package/kwrt-packages

#rm -rf feeds/packages/net/adguardhome
git clone --depth 1 https://github.com/kenzok8/small-package.git package/kz8-small
#mv package/kz8-small/adguardhome package/adguardhome
mv package/kz8-small/luci-app-adguardhome package/luci-app-adguardhome
mv package/kz8-small/luci-app-easymesh package/luci-app-easymesh
mv package/kz8-small/luci-app-onliner package/luci-app-onliner
mv package/kz8-small/luci-app-partexp package/luci-app-partexp
mv package/kz8-small/luci-app-pptp-server package/luci-app-pptp-server
mv package/kz8-small/luci-app-pushbot package/luci-app-pushbot
mv package/kz8-small/luci-app-wrtbwmon package/luci-app-wrtbwmon
mv package/kz8-small/wrtbwmon package/wrtbwmon
rm -rf package/kz8-small

git clone --depth 1 -b openwrt-21.02 https://github.com/immortalwrt/luci.git package/imm21-luci
mv package/imm21-luci/applications/luci-app-filetransfer package/luci-app-filetransfer
#sed -i 's#../../luci.mk#$(TOPDIR)/feeds/luci/luci.mk#g' package/luci-app-accesscontrol/Makefile
sed -i 's#../../luci.mk#$(TOPDIR)/feeds/luci/luci.mk#g' package/luci-app-filetransfer/Makefile
#sed -i 's#../../luci.mk#$(TOPDIR)/feeds/luci/luci.mk#g' package/luci-app-v2ray-server/Makefile
mv package/imm21-luci/libs/luci-lib-fs package/luci-lib-fs
rm -rf package/imm21-luci

#if grep -q "uugamebooster=y" "$GITHUB_WORKSPACE/$CONFIG_FILE"; then
#    mv $GITHUB_WORKSPACE/patch/Makefile-uugame package/uugamebooster/Makefile
#fi
#修改qca-nss-drv启动顺序
sed -i 's/START=.*/START=85/g' feeds/nss_packages/qca-nss-drv/files/qca-nss-drv.init
#修改qca-nss-pbuf启动顺序
sed -i 's/START=.*/START=86/g' package/kernel/mac80211/files/qca-nss-pbuf.init
#修复TailScale配置文件冲突
sed -i '/\/files/d'  feeds/packages/net/tailscale/Makefile
#修复Coremark编译失败
sed -i 's/mkdir/mkdir -p/g' feeds/packages/utils/coremark/Makefile
