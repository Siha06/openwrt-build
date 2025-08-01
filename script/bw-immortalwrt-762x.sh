
sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.5.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/files/bin/config_generate
sed -i 's/ImmortalWrt/OpenWrt/g' package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc
mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner

#mv $GITHUB_WORKSPACE/patch/imm-24.10/bw/mac80211.uc package/network/config/wifi-scripts/files/lib/wifi/mac80211.uc
mv $GITHUB_WORKSPACE/patch/imm-24.10/bw/diy.sh package/base-files/files/etc/uci-defaults/zz-diy.sh
#mv $GITHUB_WORKSPACE/patch/imm-24.10/bw/rc.local package/base-files/files/etc/rc.local
mv $GITHUB_WORKSPACE/patch/imm-24.10/bw/my-mac.sh package/base-files/files/etc/my-mac.sh
#mv $GITHUB_WORKSPACE/patch/imm-24.10/bw/my-crontabs package/base-files/files/etc/my-crontabs


#完全删除luci版本
sed -i "s/+ ' \/ ' : '') + (luciversion ||/:/g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
#添加编译日期
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/usr/lib/os-release
sed -i "s/%C/\/ Complied on $(date +"%Y.%m.%d")/g" package/base-files/files/etc/openwrt_release
