#!/bin/bash
#
# Copyright (c) 2026 OlaveV-bit
#
# File name: diy-part3.sh
# Description: OpenWrt DIY script part 3 (After Install feeds)
#

# 修改固件版本信息，加入编译日期
sed -i "s/DISTRIB_DESCRIPTION='*.*'/DISTRIB_DESCRIPTION='OpenWrt IPQ6000 ZN-M2 (build time: $(date +%Y%m%d))'/g" package/base-files/files/etc/openwrt_release

# design修改proxy链接
sed -i -r "s#navbar_proxy = 'passwall'#navbar_proxy = 'openclash'#g" feeds/luci/themes/luci-theme-design/luasrc/view/themes/design/header.htm || true

# ---------------------------------------------------------
# 修复重启/冷启动网口握手慢导致偶尔获取不到 IP 的问题
# ---------------------------------------------------------
# 必须先创建父目录，防止 cat 写入失败
mkdir -p package/base-files/files/etc/init.d

cat << 'EOF' > package/base-files/files/etc/init.d/network_fix
#!/bin/sh /etc/rc.common

# 让该脚本在系统所有服务启动的最后阶段执行
START=99
STOP=15

start() {
    # 延迟 5 秒，等待底层网络栈和交换机完全就绪后，强制触发一次 LAN 口刷新
    sleep 5
    ifup lan
}
EOF

# 赋予脚本可执行权限
chmod +x package/base-files/files/etc/init.d/network_fix