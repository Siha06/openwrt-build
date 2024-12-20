rm -rf feeds/packages/lang/golang
git clone --depth=1 https://github.com/sbwml/packages_lang_golang -b 23.x feeds/packages/lang/golang

rm -rf feeds/packages/net/{xray*,v2ray*,v2ray*,sing*,smartdns,shadowsocks-libev,trojan-go}
rm -rf feeds/packages/utils/v2dat
git clone --depth=1 https://github.com/vernesong/OpenClash.git  package/openclash
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall2.git package/passwall2
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages.git package/passwall-pkg
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall.git package/passwall
git clone --depth=1 https://github.com/fw876/helloworld.git package/helloworld

git clone --depth=1 -b openwrt23.05 https://github.com/immortalwrt/packages.git immpkg
mv immpkg/lang/rust package/rust
rm -rf immpkg
