sed -i 's/192.168.1.1/10.3.2.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/10.3.2.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/files/bin/config_generate
mv $GITHUB_WORKSPACE/patch/7621-237imm/zz-diy package/base-files/files/etc/uci-defaults/zz-diy
mv $GITHUB_WORKSPACE/patch/7621-237imm/dts/mt7621_netgear_r6220.dts target/linux/ramips/dts/mt7621_netgear_r6220.dts
mv $GITHUB_WORKSPACE/patch/7621-237imm/dts/mt7621_netgear_sercomm_ayx.dtsi target/linux/ramips/dts/mt7621_netgear_sercomm_ayx.dtsi
mv $GITHUB_WORKSPACE/patch/7621-237imm/dts/02_network target/linux/ramips/mt7621/base-files/etc/board.d/02_network
sed -i 's/wan/gmac1/g' target/linux/ramips/dts/mt7621_netgear_wndr3700-v5.dts

if grep -q "openclash=y" "$GITHUB_WORKSPACE/$CONFIG_FILE"; then
    git clone --depth 1 -b core https://github.com/vernesong/OpenClash.git  package/openclash-core
    tar -zxf package/openclash-core/master/meta/clash-linux-mipsle-softfloat.tar.gz -C package/base-files/files/etc/
    mv package/base-files/files/etc/clash package/base-files/files/etc/my-clash
    rm -rf package/openclash-core
fi

rm -rf package/emortal/luci-app-mwan3helper-chinaroute
rm -rf feeds/luci/themes/luci-theme-argonv3
rm -rf feeds/luci/themes/luci-theme-argonv2
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/applications/luci-app-argon-config
git clone -b 18.06 --depth 1 https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon
git clone -b 18.06 --depth 1 https://github.com/jerrykuku/luci-app-argon-config.git feeds/luci/themes/luci-theme-argon-config


#rm -rf feeds/packages/net/adguardhome
#git clone --depth 1 https://github.com/kenzok8/small-package.git package/kz8-small
#mv package/kz8-small/adguardhome package/adguardhome
#mv package/kz8-small/luci-app-adguardhome package/luci-app-adguardhome
#mv package/kz8-small/luci-app-ikoolproxy package/luci-app-ikoolproxy
#mv package/kz8-small/luci-app-wrtbwmon package/luci-app-wrtbwmon
#mv package/kz8-small/wrtbwmon package/wrtbwmon
#rm -rf package/kz8-small

