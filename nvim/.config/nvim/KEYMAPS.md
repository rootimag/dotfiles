# Neovim 快捷键指南

> `<leader>` 映射为：`Space`

## 0. ./lua/config/keymaps.lua

| 快捷键                                | 模式              | 功能                                      |
| :------------------------------------ | :---------------- | :---------------------------------------- |
| `jk`                                  | Insert            | 快速退出插入模式进入 Normal 模式          |
| `J` / `K`                             | Visual            | 向上 / 向下移动选中的代码块并自动对齐缩进 |
| `<leader>sv`                          | Normal            | 垂直新建分屏                              |
| `<leader>sh`                          | Normal            | 水平新建分屏                              |
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Normal / Terminal | 在不同窗口之间无缝向 左/下/上/右 导航跳转 |
| `<Alt-Up>` / `<Alt-k>`                | Normal            | 增加窗口高度                              |
| `<Alt-Down>` / `<Alt-j>`              | Normal            | 减少窗口高度                              |
| `<Alt-Left>` / `<Alt-h>`              | Normal            | 减少窗口宽度                              |
| `<Alt-Right>` / `<Alt-l>`             | Normal            | 增加窗口宽度                              |
| `x`                                   | Normal            | 删除单个字符（不存入系统剪贴板）          |
| `<leader>d`                           | Normal / Visual   | 删除字符/代码块（不存入系统剪贴板）       |
| `<leader>w`                           | Normal            | 快速保存当前文件                          |
| `<leader>q`                           | Normal            | 快速退出当前文件                          |
| `<leader>t`                           | Normal            | 打开终端并水平拆分                        |
| `<leader>m`                           | Normal            | 自动编译 C++ 程序                         |

## 1. ./lua/plugins/cmp.lua

代码补全

| 快捷键    | 模式   | 功能                               |
| :-------- | :----- | :--------------------------------- |
| `<C-o>`   | Insert | 手动触发代码补全提示框             |
| `<Tab>`   | Insert | 向下选择补全项 / 展开/跳转代码片段 |
| `<S-Tab>` | Insert | 向上选择补全项 / 反向跳转代码片段  |
| `<CR>`    | Insert | 确认并插入选中的补全项             |
| `<C-e>`   | Insert | 关闭 / 取消补全菜单                |
| `<C-b>`   | Insert | 向上滚动补全文档窗口               |
| `<C-f>`   | Insert | 向下滚动补全文档窗口               |

## 2. ./lua/plugins/bufferline.lua

标签页（Buffer）管理

| 快捷键       | 模式   | 功能                   |
| :----------- | :----- | :--------------------- |
| `<Tab>`      | Normal | 切换到下一个 Buffer    |
| `<S-Tab>`    | Normal | 切换到上一个 Buffer    |
| `<C-Left>`   | Normal | 将当前 Buffer 向左平移 |
| `<C-Right>`  | Normal | 将当前 Buffer 向右平移 |
| `<leader>bd` | Normal | 关闭当前 Buffer        |
| `<leader>bc` | Normal | 交互挑选并关闭 Buffer  |
| `<leader>bp` | Normal | 固定 / 取消固定 Buffer |
| `<leader>bo` | Normal | 关闭其他所有 Buffer    |

## 3. ./lua/plugins/autopairs.lua

自动括号（Autopairs）管理

| 快捷键             | 模式   | 功能                        |
| :----------------- | :----- | :-------------------------- |
| `<A-e>` (插入模式) | Normal | 触发 Fast Wrap 快速包裹模式 |

## 4. ./lua/plugins/comment.lua

代码注释（Comment）管理

| 快捷键  | 模式                     | 功能                             |
| :------ | :----------------------- | :------------------------------- |
| `<C-/>` | Normal / Visual / Insert | 快速切换单行或选中区域的代码注释 |

## 5. ./lua/plugins/conform.lua

代码格式化（Conform）管理

| 快捷键      | 模式            | 功能                                 |
| :---------- | :-------------- | :----------------------------------- |
| `<leader>f` | Normal / Visual | 手动格式化当前 Buffer 或选中的代码块 |

## 6. ./lua/plugins/dap.lua

代码调试（DAP）管理

| 快捷键       | 模式   | 功能                            |
| :----------- | :----- | :------------------------------ |
| `<F5>`       | Normal | 启动调试 / 继续执行（Continue） |
| `<F10>`      | Normal | 单步跳过（Step Over）           |
| `<F11>`      | Normal | 单步步入（Step Into）           |
| `<F12>`      | Normal | 单步步出（Step Out）            |
| `<leader>b`  | Normal | 切换普通断点                    |
| `<leader>B`  | Normal | 设置条件断点                    |
| `<leader>dx` | Normal | 终止当前调试会话                |
| `<leader>du` | Normal | 手动切换 DAP UI 界面显隐        |

## 7. ./lua/plugins/lsp.lua

LSP 与代码语言服务管理

| 快捷键       | 模式            | 功能                                  |
| :----------- | :-------------- | :------------------------------------ |
| `gd`         | Normal          | 跳转到定义（Go to Definition）        |
| `gD`         | Normal          | 跳转到声明（Go to Declaration）       |
| `gi`         | Normal          | 跳转到实现（Go to Implementation）    |
| `gr`         | Normal          | 查找所有引用（Find References）       |
| `K`          | Normal          | 查看悬浮文档（Hover Documentation）   |
| `<leader>rn` | Normal          | 重命名变量/函数（Rename Symbol）      |
| `<leader>ca` | Normal / Visual | 代码重构建议与快速修复（Code Action） |
| `[d`         | Normal          | 跳到上一个诊断错误/警告               |
| `]d`         | Normal          | 跳到下一个诊断错误/警告               |

## 8. ./lua/plugins/neo-tree.lua

文件树侧边栏与目录结构浏览

| 快捷键      | 模式             | 功能                             |
| :---------- | :--------------- | :------------------------------- |
| `<leader>n` | Normal           | 切换显示/隐藏侧边栏文件树        |
| `l`         | Normal（侧边栏） | 展开当前目录或打开当前选中的文件 |
| `h`         | Normal（侧边栏） | 折叠当前选中的目录节点           |
| `P`         | Normal（侧边栏） | 开启 / 关闭当前文件的悬浮窗预览  |
| `a`         | Normal（侧边栏） | 新建文件或新建文件夹             |
| `d`         | Normal（侧边栏） | 删除当前选中的文件或文件夹       |
| `r`         | Normal（侧边栏） | 重命名当前选中的文件或文件夹     |
| `y`         | Normal（侧边栏） | 复制当前节点路径到剪贴板         |
| `x`         | Normal（侧边栏） | 剪切文件或文件夹                 |
| `c`         | Normal（侧边栏） | 复制文件或文件夹                 |
| `p`         | Normal（侧边栏） | 粘贴已剪切或复制的文件/文件夹    |

## 9. ./lua/plugins/neocodeium.lua

Codeium AI 代码智能补全

| 快捷键    | 模式   | 功能                             |
| :-------- | :----- | :------------------------------- |
| `<Alt-n>` | Insert | 接受当前完整的 AI 补全建议       |
| `<Alt-w>` | Insert | 仅接受当前补全建议的下一个单词   |
| `<Alt-c>` | Insert | 清除 / 拒绝当前的 AI 补全建议    |
| `<Alt-[>` | Insert | 切换并预览下一个备选 AI 补全建议 |

## 10. ./lua/plugins/noice.lua

现代化消息通知、命令行与 UI 界面重构（Noice）

| 快捷键       | 模式   | 功能                                |
| :----------- | :----- | :---------------------------------- |
| `<leader>N`  | Normal | 打开 Noice 历史消息记录面板         |
| `<leader>Nd` | Normal | 清除 / 关闭当前屏幕上所有的通知气泡 |
| `<leader>Nl` | Normal | 查看上一条核心 Noice 消息详情       |

## 11. ./lua/plugins/yazi.lua

Yazi 终端文件管理器

| 快捷键       | 模式            | 功能                                    |
| :----------- | :-------------- | :-------------------------------------- |
| `<leader>e`  | Normal / Visual | 在当前工作目录（CWD）打开 Yazi          |
| `<leader>cw` | Normal          | 在当前正在编辑的文件所在目录下打开 Yazi |

## 12 ./lua/plugins/which-key.lua

快捷键提示

| 快捷键      | 模式   | 功能               |
| :---------- | :----- | :----------------- |
| `<leader>?` | Normal | 打开快捷键提示面板 |

## 13. ./lua/plugins/codecompanion.lua

Ai 代码对话

| 快捷键       | 模式            | 功能                  |
| :----------- | :-------------- | :-------------------- |
| `<leader>cc` | Normal          | 打开 AI 代码对话面板  |
| `<leader>cs` | Normal / Visual | 触发行内代码对话/重构 |
| `<leader>gh` | Normal          | 呼出历史聊天记录      |
| `<leader>sc` | Normal          | 手动保存聊天记录      |
