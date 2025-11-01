#sed -i 's/192.168.6.1/10.3.2.1/g' package/base-files/files/bin/config_generate
#sed -i "s/192\.168\.[0-9]*\.[0-9]*/10.3.2.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
#sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/files/bin/config_generate
mv $GITHUB_WORKSPACE/patch/7621-237imm/zz-diy package/base-files/files/etc/uci-defaults/zz-diy

#白雾定制
sed -i 's/192.168.6.1/192.168.5.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.5.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/files/bin/config_generate
mv $GITHUB_WORKSPACE/patch/tiktok/7621/bw-diy.sh package/base-files/files/etc/uci-defaults/zz-diy.sh
mv $GITHUB_WORKSPACE/patch/tiktok/7621/bw-index.htm package/base-files/files/etc/bw-index.htm
#mv $GITHUB_WORKSPACE/patch/tiktok/7621/bw-school-index.htm package/base-files/files/etc/bw-index.htm
#rm -rf feeds/luci/applications/luci-app-ua2f
#rm -rf feeds/packages/net/ua2f/*
#git clone --depth 1 https://github.com/lucikap/luci-app-ua2f.git package/luci-app-ua2f
#git clone --depth 1 https://github.com/Zxilly/UA2F.git package/ua2f
#mv package/ua2f/openwrt/* feeds/packages/net/ua2f
#rm -rf package/ua2f

if grep -q "openclash=y" "$GITHUB_WORKSPACE/$CONFIG_FILE"; then
    git clone --depth 1 -b core https://github.com/vernesong/OpenClash.git  package/openclash-core
    tar -zxf package/openclash-core/master/meta/clash-linux-mipsle-softfloat.tar.gz -C package/base-files/files/etc/
    mv package/base-files/files/etc/clash package/base-files/files/etc/my-clash
    rm -rf package/openclash-core
fi


rm -rf package/emortal/luci-app-mwan3helper-chinaroute
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/applications/luci-app-argon-config
git clone -b 18.06 --depth 1 https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon
git clone -b 18.06 --depth 1 https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
git clone --depth 1 https://github.com/Erope/openwrt_nezha.git package/openwrt_nezha
git clone --depth 1 -b lua https://github.com/sirpdboy/luci-app-ddns-go.git package/ddns-go
git clone --depth 1 https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter

rm -rf feeds/packages/lang/golang
git clone --depth 1 https://github.com/sbwml/packages_lang_golang -b 25.x feeds/packages/lang/golang

rm -rf feeds/packages/net/{mosdns,v2ray-geodata}
rm -rf feeds/luci/applications/{luci-app-openclash,luci-app-passwall,luci-app-ssr-plus,luci-app-mosdns}
rm -rf feeds/luci/applications/luci-app-openclash
git clone --depth 1 https://github.com/vernesong/OpenClash.git  package/openclash
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall.git package/passwall
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall2.git package/passwall2
git clone --depth 1 https://github.com/sbwml/v2ray-geodata package/v2ray-geodata
git clone --depth 1 https://github.com/sbwml/luci-app-mosdns -b v5-lua package/mosdns

# iStore
git clone --depth 1 -b main https://github.com/linkease/istore.git package/istore
git clone --depth 1 -b master https://github.com/linkease/nas-packages.git package/nas-packages
git clone --depth 1 -b main https://github.com/linkease/nas-packages-luci.git package/nas-luci
mv package/nas-packages/network/services/* package/nas-packages/
rm -rf package/nas-packages/network

rm -rf feeds/packages/net/adguardhome
git clone --depth 1 https://github.com/kenzok8/small-package.git package/kz8-small
mv package/kz8-small/adguardhome package/adguardhome
mv package/kz8-small/luci-app-adguardhome package/luci-app-adguardhome
mv package/kz8-small/luci-app-ikoolproxy package/luci-app-ikoolproxy
mv package/kz8-small/luci-app-wrtbwmon package/luci-app-wrtbwmon
mv package/kz8-small/wrtbwmon package/wrtbwmon
rm -rf package/kz8-small

#git clone --depth 1 https://github.com/coolsnowwolf/lede.git package/lede
#mv package/lede/package/lean/luci-app-leigod-acc package/luci-app-leigod-acc
#mv package/lede/package/lean/leigod-acc package/leigod-acc
#rm -rf package/lede

#git clone --depth 1 -b openwrt-21.02 https://github.com/immortalwrt/packages.git package/imm21-packages
#mv package/imm21-packages/net/conntrack-tools package/conntrack-tools
#mv package/imm21-packages/lang/golang feeds/packages/lang/golang
#rm -rf package/imm21-packages
