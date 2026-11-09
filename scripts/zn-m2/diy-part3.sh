#!/bin/bash
#
# Copyright (c) 2026 OlaveV-bit
#
# File name: diy-part3.sh
# Description: OpenWrt DIY script part 3 (After Install feeds)
#

# 修改默认 IP（如果需要请取消注释）
#sed -i 's/192.168.1.1/192.168.100.1/g' package/base-files/files/bin/config_generate

# 修改固件版本信息，加入编译日期
sed -i "s/DISTRIB_DESCRIPTION='*.*'/DISTRIB_DESCRIPTION='OpenWrt IPQ6000 ZN-M2 (build time: $(date +%Y%m%d))'/g" package/base-files/files/etc/openwrt_release

# 替换 golang 版本为更稳健的 22.x
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 22.x feeds/packages/lang/golang

# ttyd免登陆
#sed -i -r 's#/bin/login#/bin/login -f root#g' feeds/packages/utils/ttyd/files/ttyd.config

# design修改proxy链接
sed -i -r "s#navbar_proxy = 'passwall'#navbar_proxy = 'openclash'#g" feeds/luci/themes/luci-theme-design/luasrc/view/themes/design/header.htm

# ---------------------------------------------------------
# 修复重启/冷启动网口握手慢导致偶尔获取不到 IP 的问题
# ---------------------------------------------------------
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
