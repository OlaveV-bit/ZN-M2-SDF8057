#!/bin/bash
set -euo pipefail
cd openwrt/bin/targets/*/*
rm -rf packages
echo "FIRMWARE=$PWD" >> "$GITHUB_ENV"
mkdir -p /tmp/release-firmware

copy_without_suffix() {
  local src="$1"
  local fn
  fn=$(basename "$src")
  cp "$src" "/tmp/release-firmware/$fn"
}

for f in /tmp/firmware-basic/*; do
  copy_without_suffix "$f"
done

# 自动为所有生成的固件文件计算并生成 sha256sums 校验文件
cd /tmp/release-firmware
sha256sum * > sha256sums.txt

echo "Release firmware files & checksums:"
ls -la /tmp/release-firmware/