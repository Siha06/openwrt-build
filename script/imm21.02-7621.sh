sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.23.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/files/bin/config_generate

sed -i 's/ImmortalWrt/OpenWrt/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#mv $GITHUB_WORKSPACE/patch/imm21.02/mac80211.sh $OPENWRT_PATH/package/kernel/mac80211/files/lib/wifi/mac80211.sh
mv $GITHUB_WORKSPACE/patch/imm21.02/199-mt762x package/base-files/files/etc/uci-defaults/199-mt762x
sed -i 's#mirrors.vsean.net/openwrt#mirror.nju.edu.cn/immortalwrt#g' package/emortal/default-settings/files/99-default-settings-chinese
mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner

if grep -q "openclash=y" "$GITHUB_WORKSPACE/$CONFIG_FILE"; then
    git clone --depth 1 -b core https://github.com/vernesong/OpenClash.git  package/openclash-core
    mv package/openclash-core/master/meta/clash-linux-arm64.tar.gz package/base-files/files/etc/clash-linux-arm64.tar.gz
    rm -rf package/openclash-core
fi

#完全删除luci版本,缩减luci长度
sed -i "s/+ ' \/ ' : '') + (luciversion ||/:/g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
#sed -i "s/+ ' ' + luciversion.revision//" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
#添加编译日期
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/usr/lib/os-release
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/etc/openwrt_release

git clone --depth 1 https://github.com/coolsnowwolf/lede.git package/lede
mv package/lede/package/lean/luci-app-leigod-acc package/luci-app-leigod-acc
mv package/lede/package/lean/leigod-acc package/leigod-acc
rm -rf package/lede

#有编译openwrt环境后，加入UA2F模块和RKP-IPID模块
#git clone https://github.com/lucikap/luci-app-ua2f.git package/luci-app-ua2f
#git clone https://github.com/EOYOHOO/UA2F.git package/UA2F
#git clone https://github.com/EOYOHOO/rkp-ipid.git package/rkp-ipid
#rm -rf feeds/packages/net/ua2f
#rm -rf feeds/luci/applications/luci-app-ua2f

#安装最新openclash
rm -rf feeds/luci/applications/luci-app-openclash
git clone --depth=1 https://github.com/vernesong/OpenClash.git  package/openclash
mv package/openclash/luci-app-openclash feeds/luci/applications/
rm -rf package/openclash


# 添加kenzok8_small插件库, 编译新版Sing-box和hysteria，需golang版本1.20或者以上版本 ，可以用以下命令
rm -rf feeds/packages/lang/golang
git clone --depth 1 https://github.com/sbwml/packages_lang_golang -b 24.x feeds/packages/lang/golang
#删除自带的老旧依赖，ssr-plus，passwall
rm -rf feeds/packages/net/{chinadns-ng,dns2socks,dns2tcp,hysteria,ipt2socks,microsocks,naiveproxy}
rm -rf feeds/packages/net/{pdnsd-alt,simple-obfs,sing-box,tcping,trojan*,tuic-client,v2ray*,xray*,mosdns,redsocks2}
rm -rf feeds/packages/net/{ssocks,shadow-tls}
rm -rf feeds/packages/devel/gn
rm -rf feeds/packages/utils/v2dat
rm -rf feeds/luci/applications/{luci-app-passwall,luci-app-ssr-plus,luci-app-mosdns}

git clone --depth 1 https://github.com/fw876/helloworld.git package/helloworld
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall-packages.git package/passwall-packages
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall.git package/luci-app-passwall
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall2.git package/luci-app-passwall2

#新版ssr-libev和ss-rust缺少依赖，所以延用旧版，删除新版
rm -rf package/passwall-packages/shadowsocks-rust
rm -rf package/passwall-packages/shadowsocksr-libev
rm -rf package/helloworld/shadowsocks-rust
rm -rf package/helloworld/shadowsocksr-libev
#rm -rf package/helloworld/gn

rm -rf feeds/packages/net/v2ray-geodata
find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
find ./ | grep Makefile | grep mosdns | xargs rm -f
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

# iStore
git clone --depth=1 -b master https://github.com/linkease/nas-packages.git package/mypackage/nas-packages
git clone --depth=1 -b main https://github.com/linkease/nas-packages-luci.git package/mypackage/nas-luci
mv package/mypackage/nas-packages/network/services/* package/mypackage/nas-packages/
rm -rf package/mypackage/nas-packages/network

#下载5g模块
git clone --depth=1 https://github.com/Siriling/5G-Modem-Support.git package/5g-modem
sed -i '/pcie_mhi/d' package/5g-modem/luci-app-modem/Makefile
#sed -i 's/移动通信模组/通信模组/g' package/5g-modem/luci-app-modem/po/zh-cn/modem.po
#sed -i 's/移动通信模组/通信模组/g' package/5g-modem/luci-app-modem/po/zh_Hans/modem.po
#sed -i 's/\"network\"/\"modem\"/g' package/5g-modem/luci-app-modem/luasrc/controller/modem.lua
rm -rf feeds/packages/net/quectel-cm
rm -rf feeds/packages/kernel/fibocom-qmi-wwan
rm -rf feeds/packages/kernel/quectel-qmi-wwan
rm -rf feeds/luci/protocols/luci-proto-quectel

git clone --depth 1 https://github.com/gdy666/luci-app-lucky.git package/luci-app-lucky
#git clone --depth=1 https://github.com/kenzok8/small-package.git package/small-package
#mv package/small-package/luci-app-adguardhome package/luci-app-adguardhome
#rm -rf feeds/packages/net/adguardhome
#mv package/small-package/adguardhome package/adguardhome
#mv package/small-package/luci-app-ikoolproxy package/luci-app-ikoolproxy
#mv package/small-package/luci-app-alist package/luci-app-alist
#mv package/small-package/alist package/alist
#rm -rf feeds/packages/net/alist
#rm -rf feeds/luci/applications/luci-app-alist
#mv package/small-package/frp package/frp
#rm -rf feeds/packages/net/frp
#rm -rf package/small-package

rm -rf feeds/luci/applications/luci-app-msd_lite
rm -rf feeds/packages/net/msd_lite
git clone --depth 1 -b openwrt-23.05 https://github.com/immortalwrt/luci package/imm23luci
mv package/imm23luci/applications/luci-app-msd_lite feeds/luci/applications/luci-app-msd_lite
rm -rf package/imm23luci
git clone --depth 1 -b openwrt-23.05 https://github.com/immortalwrt/packages package/imm23packages
mv package/imm23packages/net/msd_lite feeds/packages/net/msd_lite
rm -rf package/imm23packages


#mv $GITHUB_WORKSPACE/patch/imm21.02/virtualhere/199-mydef.sh package/base-files/files/etc/uci-defaults/199-mydef.sh
#mv $GITHUB_WORKSPACE/patch/imm21.02/virtualhere/virtualhere package/base-files/files/etc/virtualhere
#mv $GITHUB_WORKSPACE/patch/imm21.02/virtualhere/config.ini package/base-files/files/etc/config.ini
