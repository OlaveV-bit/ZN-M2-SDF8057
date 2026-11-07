#!/bin/bash
set -euo pipefail
echo "release_tag=ZN-M2-$(date +'%Y.%m.%d-%H%M')" >> "$GITHUB_OUTPUT"
echo "release_name=IPQ6000 ZN-M2 Firmware $(date +'%Y.%m.%d')" >> "$GITHUB_OUTPUT"

cat << EOF > release.txt
🚀 **ZN-M2 (IPQ6000) 硬件定制固件**
- 架构底座：IPQ6000 (OpenWrt 21.02)
- 硬件优化：适配 1GB 大内存与 USB 供电强化版
- 核心服务：OpenClash + MosDNS 分流解析
- 清理解耦：移除 Passwall 及 gecoosac 残留
- 防火墙：iptables + TPROXY 转发模式
EOF
