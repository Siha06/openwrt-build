sed -i 's/192.168.1.1/10.1.1.1/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/10.1.1.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/ImmortalWrt/OpenWrt/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i 's/ImmortalWrt/OpenWrt/g' include/version.mk
mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner
cp package/base-files/files/etc/banner package/emortal/default-settings/files/openwrt_banner
mv $GITHUB_WORKSPACE/patch/imm-18.06/199-mt762x package/base-files/files/etc/uci-defaults/zz-diy
mv $GITHUB_WORKSPACE/patch/imm-18.06/auto-change.sh package/base-files/files/etc/auto-change.sh
sed -i '/passwd/d' package/emortal/default-settings/files/99-default-settings-chinese
sed -i 's#mirrors.pku.edu.cn/immortalwrt#mirrors.vsean.net/openwrt#g' package/emortal/default-settings/files/99-default-settings-chinese

#安装最新openclash
rm -rf feeds/luci/applications/luci-app-openclash
git clone --depth 1 https://github.com/vernesong/OpenClash.git  package/openclash
mv package/openclash/luci-app-openclash feeds/luci/applications/
rm -rf package/openclash

#git clone --depth 1 https://github.com/lllrrr/luci-app-sfe.git package/luci-app-sfe
#mv $GITHUB_WORKSPACE/patch/lean/luci-app-sfe.zip package/luci-app-sfe.zip
#unzip package/luci-app-sfe.zip -d package/luci-app-sfe


rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/applications/luci-app-argon-config
git clone -b 18.06 --depth 1 https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon
git clone -b 18.06 --depth 1 https://github.com/jerrykuku/luci-app-argon-config feeds/luci/applications/luci-app-argon-config

#git clone --depth 1 https://github.com/kenzok8/openwrt-packages.git  package/openwrt-packages
#mv package/openwrt-packages/luci-theme-design package/luci-theme-design
#rm -rf package/openwrt-packages

#有编译openwrt环境后，加入UA2F模块和RKP-IPID模块
#git clone --depth 1 https://github.com/lucikap/luci-app-ua2f.git package/luci-app-ua2f
#git clone --depth 1 https://github.com/Zxilly/UA2F.git package/ua2f
#git clone https://github.com/EOYOHOO/UA2F.git package/UA2F
#git clone https://github.com/EOYOHOO/rkp-ipid.git package/rkp-ipid
#rm -rf feeds/packages/net/ua2f
#rm -rf feeds/luci/applications/luci-app-ua2f
# git clone --depth 1 https://github.com/sirpdboy/luci-app-eqosplus package/luci-app-eqosplus


# git clone -b openwrt-21.02 --single-branch --depth=1 https://github.com/immortalwrt/luci.git package/imm21pkg
# mv package/imm21pkg/protocols/luci-proto-sstp package/luci-proto-sstp
# rm -rf package/imm21pkg
# sed -i '13d' package/luci-proto-sstp/Makefile
# sed -i '13i\include $(TOPDIR)/feeds/luci/luci.mk' package/luci-proto-sstp/Makefile
# rm -rf package/luci-proto-sstp/Makefile
