sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.23.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/ImmortalWrt/Xtreme_Link/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/Xtreme_Link/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i 's#mirrors.vsean.net/openwrt#mirror.nju.edu.cn/immortalwrt#g' package/emortal/default-settings/files/99-default-settings-chinese
mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner
sed -i 's/ImmortalWrt/OpenWrt/g' include/version.mk

mv $GITHUB_WORKSPACE/patch/xtreme/199-762x package/base-files/files/etc/uci-defaults/zz-diy
mv $GITHUB_WORKSPACE/patch/xtreme/10_system.js feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js

mv $GITHUB_WORKSPACE/patch/xtreme/bg1.jpg feeds/luci/themes/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg
mv $GITHUB_WORKSPACE/patch/xtreme/argon.svg feeds/luci/themes/luci-theme-argon/htdocs/luci-static/argon/img/argon.svg
mv $GITHUB_WORKSPACE/patch/xtreme/footer.htm feeds/luci/themes/luci-theme-argon/luasrc/view/themes/argon/footer.htm
mv $GITHUB_WORKSPACE/patch/xtreme/footer_login.htm feeds/luci/themes/luci-theme-argon/luasrc/view/themes/argon/footer_login.htm

#完全删除luci版本,缩减luci长度
sed -i "s/+ ' \/ ' : '') + (luciversion ||/:/g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
#添加编译日期
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/usr/lib/os-release
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/etc/openwrt_release

if grep -q "openclash=y" "$GITHUB_WORKSPACE/$CONFIG_FILE"; then
    git clone --depth 1 -b core https://github.com/vernesong/OpenClash.git  package/openclash-core
    tar -zxf package/openclash-core/master/meta/clash-linux-mipsle-softfloat.tar.gz -C package/base-files/files/etc/
    mv package/base-files/files/etc/clash package/base-files/files/etc/my-clash
    rm -rf package/openclash-core
fi

