#!/bin/bash
set -euo pipefail

MANIFEST=$(ls "$FIRMWARE"/*.manifest | head -1)
OPENCLASH_VER=$(grep -m1 "luci-app-openclash" "$MANIFEST" | awk -F' - ' '{print $2}' || true)

FALLBACK_TAG="build-${GITHUB_RUN_NUMBER}"
if [ -z "$OPENCLASH_VER" ]; then
  echo "WARNING: could not extract OpenClash version from manifest, use fallback tag: $FALLBACK_TAG"
  OPENCLASH_VER="$FALLBACK_TAG"
fi

echo "OpenClash version: $OPENCLASH_VER"
echo "OPENCLASH_VER=$OPENCLASH_VER" >> "$GITHUB_ENV"
echo "release_tag=${OPENCLASH_VER}" >> "$GITHUB_OUTPUT"

cat << 'EOF' > release.txt
## ZN-M2 固件
EOF

echo "" >> release.txt
echo "**OpenClash 版本:** \`$OPENCLASH_VER\`" >> release.txt
echo "" >> release.txt

grep -i "chinadns-ng" "$MANIFEST" | head -1 | awk -F' - ' '{print $2}' | awk -F'-' '{print "**ChinaDNS-NG:** `" $1 "`"}' >> release.txt || true
grep -i "mosdns" "$MANIFEST" | head -1 | awk -F' - ' '{print $2}' | awk -F'-' '{print "**MosDNS:** `" $1 "`"}' >> release.txt || true

cat << 'EOF' >> release.txt

### 固件说明
详细包信息请查看构建产物中的 manifest 文件。
EOF

echo "release_name=ZN-M2 OpenClash ${OPENCLASH_VER}" >> "$GITHUB_OUTPUT"