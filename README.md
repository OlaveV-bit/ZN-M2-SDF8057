# 兆能 ZN-M2 OpenWrt 极客定制版

纯有线主路由｜弱电箱专用｜内核 4.4.60｜1GB 大内存魔改版

控制台地址 `192.168.1.1` 默认密码 `password`

* U-Boot 刷机用 `*factory.ubi`
* OpenWrt 系统升级用 `*sysupgrade.bin`

---

## 🛠️ 硬件与环境配置

* **底层平台**：Qualcomm IPQ6000 (兆能 ZN-M2)
* **硬件魔改**：已升级至 **1GB RAM**，并加装 **USB 供电/扩展**
* **推荐拓扑**：运营商光猫 (桥接) $\rightarrow$ ZN-M2 (PPPoE 拨号主路由) $\rightarrow$ 下级无线路由器 (AP 模式)

---

## ✨ 固件核心特性

1. **Qualcomm NSS 硬件加速**：
   集成完整 NSS 加速套件（`kmod-qca-nss-drv` / `ecm` / `crypto`），实现低 CPU 占用的千兆满速转发。
2. **OpenClash & Go 22.x**：
   替换为稳定版 Golang 22.x 编译环境，完美兼容 OpenClash (Mihomo 核心) 及大内存规则分流。
3. **精美主题与细节修正**：
   集成 Argon 与 Design 双主题，并修补了 Design 主题的快捷代理跳转链接。

---

## 🔍 1GB 内存识别验证

刷入固件后，您可以通过以下方式确认系统已成功识别全部 1GB 内存：

1. **SSH 命令行**：执行 `free -h`，查看 `Mem Total` 是否在 **900MB - 1010MB** 左右。
2. **LuCI 后台**：进入 **状态** $\rightarrow$ **概览** $\rightarrow$ **系统信息** 查看内存条总量。
