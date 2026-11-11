# OpenWrt ZN-M2 (IPQ6000) 编译流程

本项目基于 GitHub Actions 实现兆能 ZN-M2 (Qualcomm IPQ6000 平台) OpenWrt 固件的编译与构建，集成 OpenClash 核心、NSS 硬件加速及相关网络增强组件。

## 🌟 项目特性

* **全新构建工具链**：工作流预先清理 runner 磁盘空间，并自动替换环境中的 Golang 至 `22.x` 分支，保障 OpenClash 及其依赖无缝编译。
* **高性能组件**：内置 IPQ6000 平台 NSS 硬件加速驱动（`kmod-qca-nss-ecm` 等），提升硬件转发性能。
* **网络握手优化**：预置开机延迟触发 LAN 口刷新脚本，解决冷启动/重启时交换机端口握手慢导致的无法获取 IP 问题。
* **现代化 UI**：内置 Argon 与 Design 主题，并自动优化菜单导航。
* **自动化打包与 Release**：构建成功后自动清理冗余文件，动态解析包清单（Manifest）提取 OpenClash 版本号，并发布至 Releases 页面。

## 🛠️ 包含的主要插件与工具

| 类别 | 包含组件 / 插件 |
| ----- | ----- |
| **代理与核心** | `luci-app-openclash`, `openclash`, `clash-meta`, `chinadns-ng` |
| **硬件加速** | `kmod-qca-nss-drv`, `kmod-qca-nss-ecm`, `kmod-qca-nss-crypto` |
| **网络工具** | `ddns-scripts` (含阿里云/DNSPod), `luci-app-upnp`, `proto-bonding`, `luci-app-arpbind` |
| **系统工具** | `htop`, `screen`, `zram-swap`, `tcping`, `curl`, `wget-ssl`, `ip-full`, `ipset` |
| **界面主题** | `luci-theme-argon`, `luci-theme-design`, `luci-app-filetransfer` |

## 📂 项目目录结构

```text
.
├── .github/
│   └── workflows/
│       └── zn-m2.yml             # GitHub Actions 工作流配置文件
├── config/
│   └── zn-m2.config              # OpenWrt 编译配置文件 (.config)
├── scripts/zn-m2/
│   ├── diy-part1.sh              # Update feeds 前的自定义脚本
│   ├── diy-part2.sh              # Update/Install feeds 过程中的自定义脚本 (Golang 22.x 替换)
│   └── diy-part3.sh              # 配置加载后的源码修正与补丁脚本
└── feeds.conf.default            # 自定义 Feeds 源设置
```

## 🚀 使用说明

### 手动触发编译

1. 打开你的 GitHub 仓库页面。
2. 点击上方菜单栏的 **Actions**。
3. 在左侧选中 **zn-m2 build** 工作流。
4. 点击右侧的 **Run workflow** 按钮即可手动触发编译。

编译完成后，发布的固件文件及清单文件可在仓库的 **Releases** 页面直接下载。

## 📜 许可与致谢

* 源码上游：[openwrt-fork/sdf8057-ipq6000](https://github.com/openwrt-fork/sdf8057-ipq6000)
* 代理插件：[vernesong/OpenClash](https://github.com/vernesong/OpenClash)
* Golang 支持环境：[sbwml/packages_lang_golang](https://github.com/sbwml/packages_lang_golang)
