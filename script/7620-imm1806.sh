sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.23.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/ImmortalWrt/OpenWrt/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#mv $GITHUB_WORKSPACE/patch/7621-237imm/999-diy package/base-files/files/etc/uci-defaults/zz-diy
mv $GITHUB_WORKSPACE/patch/imm21.02/199-mt762x package/base-files/files/etc/uci-defaults/zz-diy

#安装最新openclash
rm -rf feeds/luci/applications/luci-app-openclash
git clone --depth 1 https://github.com/vernesong/OpenClash.git  package/openclash
mv package/openclash/luci-app-openclash feeds/luci/applications/
rm -rf package/openclash
if grep -q "openclash=y" "$GITHUB_WORKSPACE/$CONFIG_FILE"; then
    git clone --depth 1 -b core https://github.com/vernesong/OpenClash.git  package/openclash-core
    tar -zxf package/openclash-core/master/meta/clash-linux-mipsle-softfloat.tar.gz -C package/base-files/files/etc/
    mv package/base-files/files/etc/clash package/base-files/files/etc/my-clash
    rm -rf package/openclash-core
fi

#rm -rf feeds/luci/modules/luci-base/po/zh-cn
#rm -rf feeds/luci/applications/luci-app-passwall/po/zh-cn
#rm -rf feeds/luci/applications/luci-app-timecontrol/po/zh-cn
#rm -rf feeds/luci/applications/luci-app-firewall/po/zh-cn
#rm -rf feeds/luci/applications/luci-app-upnp/po/zh-cn

#git clone --depth 1 https://github.com/lllrrr/luci-app-sfe.git package/luci-app-sfe
#mv $GITHUB_WORKSPACE/patch/lean/luci-app-sfe.zip package/luci-app-sfe.zip
#unzip package/luci-app-sfe.zip -d package/luci-app-sfe

#rm -rf feeds/luci/themes/luci-theme-argonv3
#rm -rf feeds/luci/themes/luci-theme-argonv2
rm -rf feeds/luci/themes/luci-theme-argon
# rm -rf feeds/luci/applications/luci-app-argon-config
git clone -b 18.06 --depth 1 https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon
# git clone -b 18.06 --depth 1 https://github.com/jerrykuku/luci-app-argon-config feeds/luci/applications/luci-app-argon-config
#git clone --depth 1 https://github.com/kenzok8/openwrt-packages.git  package/openwrt-packages
#mv package/openwrt-packages/luci-theme-design package/luci-theme-design
#rm -rf package/openwrt-packages

# git clone --depth 1 https://github.com/sirpdboy/luci-app-eqosplus package/luci-app-eqosplus


# git clone -b openwrt-21.02 --single-branch --depth=1 https://github.com/immortalwrt/luci.git package/imm21pkg
# mv package/imm21pkg/protocols/luci-proto-sstp package/luci-proto-sstp
# rm -rf package/imm21pkg
# sed -i '13d' package/luci-proto-sstp/Makefile
# sed -i '13i\include $(TOPDIR)/feeds/luci/luci.mk' package/luci-proto-sstp/Makefile
# rm -rf package/luci-proto-sstp/Makefile
