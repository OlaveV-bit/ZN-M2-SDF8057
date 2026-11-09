#!/bin/bash
#
# 版权所有 (c) 2026 OlaveV-bit
#
# 文件名：diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 1. 优先将 Golang 替换为 22.x（支撑 OpenClash 编译）
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 22.x feeds/packages/lang/golang

# 2. 彻底清理 feeds 中自带的旧版 OpenClash，并克隆官方最新主线源码
rm -rf feeds/luci/applications/luci-app-openclash
rm -rf feeds/openclash
git clone --depth=1 https://github.com/vernesong/OpenClash.git package/openclash-source
# 提取官方仓库内部真正的 luci-app-openclash 目录
cp -r package/openclash-source/luci-app-openclash package/luci-app-openclash
rm -rf package/openclash-source

# 3. 安装所有更新后的 feeds
./scripts/feeds install -a -f