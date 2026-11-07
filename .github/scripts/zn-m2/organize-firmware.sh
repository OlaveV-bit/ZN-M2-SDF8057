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

cd /tmp/release-firmware
sha256sum * > sha256sums.txt
