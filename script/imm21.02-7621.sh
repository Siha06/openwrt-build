#sed -i 's/192.168.1.1/192.168.101.1/g' package/base-files/files/bin/config_generate
#sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.101.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
#sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/files/bin/config_generate

#sed -i 's/ImmortalWrt/OpenWrt/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#mv $GITHUB_WORKSPACE/patch/imm21.02/mac80211.sh $OPENWRT_PATH/package/kernel/mac80211/files/lib/wifi/mac80211.sh

sed -i 's#mirrors.vsean.net/openwrt#mirror.nju.edu.cn/immortalwrt#g' package/emortal/default-settings/files/99-default-settings-chinese
mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner
mv $GITHUB_WORKSPACE/patch/imm21.02/virtualhere/199-mydef.sh package/base-files/files/etc/uci-defaults/199-mydef.sh
mv $GITHUB_WORKSPACE/patch/imm21.02/virtualhere/virtualhere package/base-files/files/etc/virtualhere
mv $GITHUB_WORKSPACE/patch/imm21.02/virtualhere/config.ini package/base-files/files/etc/config.ini

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
