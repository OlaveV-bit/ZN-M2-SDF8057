#!/bin/bash
#
# 版权所有 (c) 2026 OlaveV-bit
#
# 文件名：diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
#优先安装 openclash
./scripts/feeds install -a -f -p openclash
./scripts/feeds install -a -f -p openclash_luci
