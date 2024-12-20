sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.23.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/files/bin/config_generate
sed -i 's#mirrors.vsean.net/openwrt#mirror.nju.edu.cn/immortalwrt#g' package/emortal/default-settings/files/99-default-settings-chinese
mv $GITHUB_WORKSPACE/patch/imm21.02/mac80211.sh $OPENWRT_PATH/package/kernel/mac80211/files/lib/wifi/mac80211.sh
mv $GITHUB_WORKSPACE/patch/imm21.02/defset $OPENWRT_PATH/package/emortal/default-settings/files/99-default-settings

#安装最新openclash
rm -rf feeds/luci/applications/luci-app-openclash
git clone --depth=1 https://github.com/vernesong/OpenClash.git  package/openclash
mv package/openclash/luci-app-openclash feeds/luci/applications/
rm -rf package/openclash

# 添加kenzok8_small插件库, 编译新版Sing-box和hysteria，需golang版本1.20或者以上版本 ，可以用以下命令
rm -rf feeds/packages/lang/golang
git clone --depth=1 https://github.com/kenzok8/golang feeds/packages/lang/golang
#删除自带的老旧依赖，ssr-plus，passwall
rm -rf feeds/packages/net/{brook,chinadns-ng,dns2socks,dns2tcp,hysteria,ipt2socks,microsocks,naiveproxy}
rm -rf feeds/packages/net/{pdnsd-alt,simple-obfs,sing-box,tcping,trojan*,tuic-client,v2ray*,xray*,mosdns,redsocks2}
rm -rf feeds/packages/net/{ssocks,shadow-tls}
rm -rf feeds/packages/devel/gn
rm -rf feeds/packages/utils/v2dat
rm -rf feeds/luci/applications/{luci-app-passwall,luci-app-ssr-plus,luci-app-mosdns}

#git clone --depth=1 https://github.com/fw876/helloworld.git package/helloworld
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages.git package/passwall-packages
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall.git package/luci-app-passwall
#git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall2.git package/luci-app-passwall2

#新版ssr-libev和ss-rust缺少依赖，所以延用旧版，删除新版
rm -rf package/passwall-packages/shadowsocks-rust
rm -rf package/passwall-packages/shadowsocksr-libev
rm -rf package/helloworld/shadowsocks-rust
rm -rf package/helloworld/shadowsocksr-libev

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

git clone --depth=1 https://github.com/gdy666/luci-app-lucky.git package/luci-app-lucky
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
