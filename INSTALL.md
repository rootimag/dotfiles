# 🛠️ Installation Guide

欢迎使用本配置文件。请按照以下步骤进行部署，以确保 **Matugen** 能够正确接管系统色彩。

---

## 文件目录

.
├── [matugen](#matugen)/             # matugen 色彩动态更新             
├── [scripts](#scripts)/             # 共用脚本，包括 matugen更新和截图 
└── [niri](#niri)/                   # niri 配置

[一键安装脚本](#安装脚本)

---

### niri

依赖安装：
| 软件包(建议安装) | 描述 |
| --- | --- |
| niri | Wayland 合成器 |
| rofi | 应用启动器 |
| thunar | 文件管理器 |
| kitty | 终端模拟器 |
| waybar | 系统状态栏 |
| waypaper swww swaybg | 壁纸切换 |
| satty | 编辑截图 |
| wireplumber | 音量控制 |
| playerctl | 媒体控制 |
| brightnessctl | 亮度控制 |
| firefox | 浏览器 |
| hyprlock | 锁屏 |
| clipse wl-clipboard | 剪贴板 | 
| hyprpicker | 提取颜色 | 
| fcitx5-im fcitx5-rime | 输入法 |
| matugen | 配色生成 |
| polkit-gnome | 认证代理 |
| impala iwd | 网络链接 |

---

依赖配置文件: 
| 依赖 | 描述 |
| --- | --- |
| ~/.config/scripts/matugen-update.sh | 更新 matugen 配置 |
| ~/.config/scripts/swayidle.sh | 自动熄屏 | 
| ~/.config/scripts/screenshot.sh | 截屏脚本 |
| ~/.config/scripts/niri\_auto\_blur\_bg.sh | 自动模糊 |
| ~/.config/matugen/config.toml | 生成配色方案 |

---

### scripts

| 软件包(必须安装) | 描述 |
| --- | --- |
| imagemagick | 处理图片 |
| jq | 读取 json |
| satty | 编辑截图 |
| swayidle | 自动熄屏 |
| matugen | 配色生成 |
| rofi | 应用启动器 |
| hyprlock | 锁屏 |
| swww swaybg | 壁纸模糊 |

---

### matugen 

| 软件包(必须安装) | 描述 |
| --- | --- |
| matugen | 配色生成 |
| niri | Wayland 合成器 |

---

### 安装脚本

**📜 脚本核心逻辑说明 (Script Developer Guide)**

本脚本不仅是一个简单的安装器，而是一个小型指令解析引擎。它将“文件结构”与“执行逻辑”完全分离，通过 .setup/ 目录下的规则文件驱动

**1. 核心设计模式**

**📦 指令驱动 (Instruction-Driven)**

脚本不再扫描你的配置文件内容，而是扫描 .setup/ 文件夹

- **解耦**：你想安装 niri，只需在 .setup/niri-setup 里写下逻辑

- **顺序控制**：脚本严格按照你文件中的行顺序执行（先装包 -> 再链接 -> 后初始化）

**🎨 界面渲染**

使用 Gum (Charmbracelet) 提供的 TUI 能力：

- `gum choose`: 提供多选组件的交互菜单

- `gum spin`: 在静默模式下提供动画等待效果

- `gum log`: 统一处理带前缀的格式化输出

---

**2. 指令集定义**

脚本识别以下三种前缀：

1. `pkg`: (包管理器)

自动检测系统中的 yay 或 paru

2. `stow`: (链接器)

- `stow: ~` (链接到家目录)

- `stow: /etc/configs` (链接到指定路径)

3. `cmd`: (命令执行)

暂不支持执行多行命令，可通过 `&&` 执行多个命令

**3. 状态标识符说明**

为了视觉对齐和简洁，脚本重写了 `gum log` 的前缀：

| 标签 | 触发场景 |
| --- | --- |
| [INFO] | 任务成功执行完毕 |
| [EVENT] | 脚本正在解析文件或准备开始任务 |
| [WARN] | 找不到 .setup 文件或用户手动跳过了步骤 |
| [WRONG] | 命令返回非零状态码，任务执行失败 |
