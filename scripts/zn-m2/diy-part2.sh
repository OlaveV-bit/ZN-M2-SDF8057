#!/bin/bash
#
# 版权所有 (c) 2026 OlaveV-bit
#
# 文件名：diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 1. 优先将 Golang 替换为 22.x（必须在 feeds install 前完成，以支撑 OpenClash 编译）
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 22.x feeds/packages/lang/golang

# 2. 安装所有更新后的 feeds（包含 feeds.conf.default 中的 openclash）
./scripts/feeds install -a -f