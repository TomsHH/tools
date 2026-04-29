# CLI Tools Launcher

Windows 环境下的 AI 编程助手快速启动工具集，提供右键菜单和终端分屏两种启动方式，支持多个 AI CLI 工具。

## 功能概览

### 1. 右键菜单 (Context Menu)

在 Windows 资源管理器中右键点击**文件、文件夹或空白处**，即可通过级联菜单快速启动 AI 编程工具：

```
Open in CLI
├── Use GLM In Claude
├── Use Qwen In Claude
├── Use MiniMax In Claude
├── Use Kimi In Claude
├── Use DeepSeek In Claude
├── Use Codex
└── Use Gemini
```

菜单会在对应目录下启动 CLI 工具，自动切换工作路径。

### 2. 终端分屏 (Split Pane)

在 Windows Terminal 中按 `Ctrl+Shift+D`，弹出交互式菜单：

- 选择分屏方向（水平 / 垂直）
- 选择 AI 配置文件（GLM / Qwen / MiniMax / Kimi / DeepSeek / Codex / Gemini）
- 自动在当前终端中分屏并启动对应 CLI

## 支持的 AI 工具

| 名称 | 工具 | 模型 |
|------|------|------|
| GLM | Claude Code | glm-5.1 / glm-5-turbo / glm-4.7 |
| Qwen | Claude Code | qwen3.5-plus / qwen3-max / qwen3-coder-plus |
| MiniMax | Claude Code | MiniMax-M2.7 / MiniMax-M2.5 / MiniMax-M2 |
| Kimi | Claude Code | kimi-k2.5 / kimi-k2-thinking / kimi-linear |
| DeepSeek | Claude Code | deepseek-chat |
| Codex | OpenAI Codex CLI | - |
| Gemini | Google Gemini CLI | - |

> GLM / Qwen / MiniMax / Kimi / DeepSeek 均通过 Anthropic 兼容接口接入 Claude Code。

## 安装

### 前置条件

- Windows 10/11
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI 已安装（用于 GLM/Qwen/MiniMax/Kimi/DeepSeek）
- [Windows Terminal](https://aka.ms/terminal)（分屏功能需要）

### 安装右键菜单

以**管理员身份**运行：

```
Tool\Install CLI Menu\Install-CLI-Menu.bat
```

安装脚本会自动完成：
1. 清理旧版菜单注册表项
2. 注册新的右键级联菜单
3. 创建配置文件模板（位于 `%USERPROFILE%\.claude\launchers\.settings\`）
4. 生成启动器脚本（位于 `%USERPROFILE%\.claude\launchers\.bats\`）
5. 刷新 Windows Explorer

### 安装终端分屏

以**管理员身份**运行：

```
Tool\Install CLI Menu\Install-Split-Menu.bat
```

安装脚本会自动完成：
1. 复制 `SelectAndSplit.ps1` 到用户目录
2. 在 Windows Terminal 中注册 `Ctrl+Shift+D` 快捷键
3. 配置分屏启动参数

## 配置

安装完成后，需编辑配置文件填入 API Key：

```
%USERPROFILE%\.claude\launchers\.settings\
├── glm.json        # 智谱 GLM
├── qwen.json       # 通义千问
├── minimax.json    # MiniMax
├── kimi.json       # Kimi（月之暗面）
└── deepseek.json   # DeepSeek
```

将对应配置文件中的 `YOUR_API_KEY_HERE` 替换为实际的 API Key。

## 卸载

### 卸载右键菜单

以管理员身份运行：

```
Tool\Install CLI Menu\Uninstall-CLI-Menu.bat
```

### 卸载终端分屏

以管理员身份运行：

```
Tool\Install CLI Menu\Uninstall-Spli-Menu.bat
```

## 文件结构

```
Tool/Install CLI Menu/
├── Install-CLI-Menu.bat      # 右键菜单安装脚本
├── Install-Split-Menu.bat    # 终端分屏安装脚本
├── SelectAndSplit.ps1        # 分屏交互式菜单（PowerShell）
├── Uninstall-CLI-Menu.bat    # 右键菜单卸载脚本
└── Uninstall-Spli-Menu.bat   # 终端分屏卸载脚本
```

## 许可证

MIT
