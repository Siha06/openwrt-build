
IPQ_TARGET=$(grep -o 'CONFIG_TARGET_qualcommax_[^=]*' $GITHUB_WORKSPACE/$CONFIG_FILE | sed -n 's/CONFIG_TARGET_qualcommax_//p' | head -n1)
mv $GITHUB_WORKSPACE/patch/998-kwrt-$IPQ_TARGET.sh package/base-files/files/etc/uci-defaults/998-ipq.sh

#移除luci-app-attendedsysupgrade
sed -i "/attendedsysupgrade/d" $(find ./feeds/luci/collections/ -type f -name "Makefile")
# 修改默认IP，主机名
sed -i 's/192.168.1.1/10.3.2.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/10.3.2.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i "s/immortalwrt.lan/openwrt.lan/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWRT/OpenWrt/g' include/version.mk
sed -i 's/ImmortalWrt/OpenWrt/g' feeds/luci/modules/luci-mod-network/htdocs/luci-static/resources/view/network/wireless.js
sed -i "s/%V/25.12/g" package/base-files/files/usr/lib/os-release
sed -i "s/%V/25.12/g" package/base-files/files/etc/openwrt_release
mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner
mv $GITHUB_WORKSPACE/patch/ipq-vikingyfy/mac80211.uc package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc

if grep -q "openclash=y" $GITHUB_WORKSPACE/$CONFIG_FILE; then
    echo "✅ 已选择 luci-app-openclash，添加 openclash core"
    mkdir -p files/etc/openclash/core
    # Download clash_meta
    META_URL="https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-arm64.tar.gz"
    wget -qO- $META_URL | tar xOvz > files/etc/openclash/core/clash_meta
    chmod +x files/etc/openclash/core/clash_meta
    # 下载 GeoIP 和 GeoSite
    # wget -q https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat -O files/etc/openclash/GeoIP.dat
    # wget -q https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat -O files/etc/openclash/GeoSite.dat
else
    echo "⚪️ 未选择 luci-app-openclash"
fi


#mv $GITHUB_WORKSPACE/patch/ipq-vikingyfy/998-ipq.sh package/base-files/files/etc/uci-defaults/998-ipq.sh
mv $GITHUB_WORKSPACE/patch/ipq-vikingyfy/998-ipq60xx.sh package/base-files/files/etc/uci-defaults/998-ipq.sh
#mv $GITHUB_WORKSPACE/patch/ipq-vikingyfy/998-ipq807x.sh package/base-files/files/etc/uci-defaults/998-ipq.sh

#mkdir -p package/base-files/files/diy4me
#mv $GITHUB_WORKSPACE/patch/ipq-vikingyfy/dogking/998-dogking-mulwifi.sh package/base-files/files/etc/uci-defaults/998-ipq.sh
#mv $GITHUB_WORKSPACE/patch/ipq-vikingyfy/dogking/rules-pw2-mulwifi package/base-files/files/diy4me/rules-pw2
#mv $GITHUB_WORKSPACE/patch/ipq-vikingyfy/dogking/998-dogking-sglwifi-2.sh package/base-files/files/etc/uci-defaults/998-ipq.sh
#mv $GITHUB_WORKSPACE/patch/ipq-vikingyfy/dogking/rules-pw2-sglwifi package/base-files/files/diy4me/rules-pw2

# iStore
git clone --depth=1 -b main https://github.com/linkease/istore.git package/istore
git clone --depth=1 -b master https://github.com/linkease/nas-packages.git package/nas-packages
git clone --depth=1 -b main https://github.com/linkease/nas-packages-luci.git package/nas-luci
mv package/nas-packages/network/services/* package/nas-packages/
rm -rf package/nas-packages/network

#完全删除luci版本
sed -i "s/+ ' \/ ' : '') + (luciversion ||/:/g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
#添加编译日期
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/usr/lib/os-release
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/etc/openwrt_release

#mv $GITHUB_WORKSPACE/patch/ipq-breeze/QINGYINSSIDMAC1.sh package/base-files/files/etc/QINGYINSSIDMAC1.sh
#mv $GITHUB_WORKSPACE/patch/ipq-breeze/10_system.js feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js

#下载5g模块
#git clone --depth=1 https://github.com/Siriling/5G-Modem-Support.git package/5g-modem
#rm -rf feeds/packages/net/quectel-cm
#rm -rf feeds/packages/kernel/fibocom-qmi-wwan
#rm -rf feeds/packages/kernel/quectel-qmi-wwan
#rm -rf feeds/luci/protocols/luci-proto-quectel
#rm -rf feeds/nss_packages/wwan

rm -rf feeds/packages/lang/golang
git clone --depth 1 https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang
rm -rf feeds/packages/net/{adguardhome,smartdns}
rm -rf feeds/luci/applications/{luci-app-adguardhome,luci-app-smartdns}
git clone --depth 1 https://github.com/kenzok8/jell.git package/small-package
mv package/small-package/adguardhome package/adguardhome
mv package/small-package/luci-app-adguardhome package/luci-app-adguardhome
mv package/small-package/luci-app-easymesh package/luci-app-easymesh
mv package/small-package/luci-app-ikoolproxy package/luci-app-ikoolproxy
mv package/small-package/luci-app-pushbot package/luci-app-pushbot
mv package/small-package/wrtbwmon package/wrtbwmon
mv package/small-package/luci-app-wrtbwmon package/luci-app-wrtbwmon
rm -rf package/small-package

rm -rf feeds/packages/net/{mosdns,v2ray-geodata}
rm -rf feeds/luci/applications/{luci-app-openclash,luci-app-passwall,luci-app-ssr-plus,luci-app-mosdns}
git clone --depth 1 https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone --depth 1 https://github.com/sbwml/v2ray-geodata package/v2ray-geodata
git clone --depth 1 https://github.com/vernesong/OpenClash.git  package/openclash
git clone --depth 1 https://github.com/Openwrt-Passwall/openwrt-passwall.git package/luci-app-passwall
git clone --depth 1 https://github.com/Openwrt-Passwall/openwrt-passwall2.git package/luci-app-passwall2
git clone --depth 1 https://github.com/nikkinikki-org/OpenWrt-momo.git package/OpenWrt-momo
git clone --depth 1 https://github.com/nikkinikki-org/OpenWrt-nikki.git package/OpenWrt-nikki
#git clone --depth 1 https://github.com/fw876/helloworld.git package/helloworld-ssr-plus


rm -rf feeds/packages/net/{open-app-filter}
git clone --depth 1 https://github.com/sbwml/luci-app-openlist2 package/openlist2
git clone --depth 1 https://github.com/sirpdboy/luci-app-parentcontrol package/luci-app-parentcontrol
git clone --depth 1 https://github.com/lwb1978/openwrt-gecoosac.git package/openwrt-gecoosac
git clone --depth 1 https://github.com/gdy666/luci-app-lucky.git package/lucky
git clone --depth 1 https://github.com/sirpdboy/netspeedtest package/netspeedtest

#git clone --depth 1 -b openwrt-21.02 https://github.com/immortalwrt/luci.git package/imm21-luci
#mv package/imm21-luci/applications/luci-app-filetransfer package/luci-app-filetransfer
#sed -i 's#../../luci.mk#$(TOPDIR)/feeds/luci/luci.mk#g' package/luci-app-accesscontrol/Makefile
#sed -i 's#../../luci.mk#$(TOPDIR)/feeds/luci/luci.mk#g' package/luci-app-filetransfer/Makefile
#sed -i 's#../../luci.mk#$(TOPDIR)/feeds/luci/luci.mk#g' package/luci-app-v2ray-server/Makefile
#mv package/imm21-luci/libs/luci-lib-fs package/luci-lib-fs
#rm -rf package/imm21-luci

#if grep -q "uugamebooster=y" "$GITHUB_WORKSPACE/$CONFIG_FILE"; then
#    mv $GITHUB_WORKSPACE/patch/Makefile-uugame package/uugamebooster/Makefile
#fi

DTS_PATH=target/linux/qualcommax/dts/
	#无WIFI配置调整Q6大小
	if grep -Eq "luci-app-nowifi=y" $GITHUB_WORKSPACE/$CONFIG_FILE; then
		find $DTS_PATH -type f ! -iname '*nowifi*' -exec sed -i 's/ipq\(6018\|8074\).dtsi/ipq\1-nowifi.dtsi/g' {} +
		echo "qualcommax set up nowifi successfully!"
	fi

#修改qca-nss-drv启动顺序
sed -i 's/START=.*/START=85/g' feeds/nss_packages/qca-nss-drv/files/qca-nss-drv.init
#修改qca-nss-pbuf启动顺序
sed -i 's/START=.*/START=86/g' package/kernel/mac80211/files/qca-nss-pbuf.init
#修复TailScale配置文件冲突
sed -i '/\/files/d'  feeds/packages/net/tailscale/Makefile
#修复Rust编译失败
sed -i 's/ci-llvm=true/ci-llvm=false/g' feeds/packages/lang/rust/Makefile
#修复DiskMan编译失败(未找到该文件)
sed -i '/ntfs-3g-utils /d' feeds/luci/applications/luci-app-diskman/Makefile
#修复Coremark编译失败（已不需要）
#sed -i 's/mkdir/mkdir -p/g' feeds/packages/utils/coremark/Makefile
#修复luci-app-netspeedtest相关问题
#sed -i '$a\exit 0' ./netspeedtest/files/99_netspeedtest.defaults
#sed -i 's/ca-certificates/ca-bundle/g' package/netspeedtest/ookla-speedtest/Makefile
