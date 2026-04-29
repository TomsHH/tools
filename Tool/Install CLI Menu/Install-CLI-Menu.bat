@echo off
chcp 65001 >nul
title Install CLI Code Context Menu
color 0A

:: Check admin rights
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo ============================================================
echo                  Install CLI Code Menu
echo ============================================================
echo.
echo   [1/6] Cleaning previous menu entries...
reg delete "HKEY_CLASSES_ROOT\Directory\Background\shell\CLICodeMenu" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\Directory\shell\CLICodeMenu" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\*\shell\CLICodeMenu" /f >nul 2>&1
echo   [OK] Previous menu entries cleared
echo.

echo [2/6] Registering Standardized Menus...
set "LAUNCHER_BAT=%USERPROFILE%\.claude\launchers\.bats\Launch Claude Code Command.bat"

:: --- Define Names ---
set "MENU_NAME=Open in CLI"
set "GLM_NAME=Use GLM In Claude"
set "QWEN_NAME=Use Qwen In Claude"
set "MINIMAX_NAME=Use MiniMax In Claude"
set "KIMI_NAME=Use Kimi In Claude"
set "DEEPSEEK_NAME=Use DeepSeek In Claude"
set "CODEX_NAME=Use Codex"
set "GEMINI_NAME=Use Gemini"

:: A. Background
set "B=HKEY_CLASSES_ROOT\Directory\Background\shell\CLICodeMenu"
reg add "%B%" /v "MUIVerb" /d "%MENU_NAME%" /f >nul 2>&1
reg add "%B%" /v "SubCommands" /d "" /f >nul 2>&1
reg add "%B%\Shell\01_Claude_GLM" /v "MUIVerb" /d "%GLM_NAME%" /f >nul 2>&1
reg add "%B%\Shell\01_Claude_GLM\command" /ve /d "cmd.exe /c call \"%LAUNCHER_BAT%\" glm.json \"%%V\"" /f >nul 2>&1
reg add "%B%\Shell\02_Claude_Qwen" /v "MUIVerb" /d "%QWEN_NAME%" /f >nul 2>&1
reg add "%B%\Shell\02_Claude_Qwen\command" /ve /d "cmd.exe /c call \"%LAUNCHER_BAT%\" qwen.json \"%%V\"" /f >nul 2>&1
reg add "%B%\Shell\03_Claude_MiniMax" /v "MUIVerb" /d "%MINIMAX_NAME%" /f >nul 2>&1
reg add "%B%\Shell\03_Claude_MiniMax\command" /ve /d "cmd.exe /c call \"%LAUNCHER_BAT%\" minimax.json \"%%V\"" /f >nul 2>&1
reg add "%B%\Shell\04_Claude_Kimi" /v "MUIVerb" /d "%KIMI_NAME%" /f >nul 2>&1
reg add "%B%\Shell\04_Claude_Kimi\command" /ve /d "cmd.exe /c call \"%LAUNCHER_BAT%\" kimi.json \"%%V\"" /f >nul 2>&1
reg add "%B%\Shell\05_Claude_DeepSeek" /v "MUIVerb" /d "%DEEPSEEK_NAME%" /f >nul 2>&1
reg add "%B%\Shell\05_Claude_DeepSeek" /v "CommandFlags" /t REG_DWORD /d 64 /f >nul 2>&1
reg add "%B%\Shell\05_Claude_DeepSeek\command" /ve /d "cmd.exe /c call \"%LAUNCHER_BAT%\" deepseek.json \"%%V\"" /f >nul 2>&1
reg add "%B%\Shell\06_Codex" /v "MUIVerb" /d "%CODEX_NAME%" /f >nul 2>&1
reg add "%B%\Shell\06_Codex\command" /ve /d "cmd.exe /c call \"%LAUNCHER_BAT%\" codex \"%%V\"" /f >nul 2>&1
reg add "%B%\Shell\07_Gemini" /v "MUIVerb" /d "%GEMINI_NAME%" /f >nul 2>&1
reg add "%B%\Shell\07_Gemini\command" /ve /d "cmd.exe /c call \"%LAUNCHER_BAT%\" gemini \"%%V\"" /f >nul 2>&1

:: B. Directory
set "D=HKEY_CLASSES_ROOT\Directory\shell\CLICodeMenu"
reg add "%D%" /v "MUIVerb" /d "%MENU_NAME%" /f >nul 2>&1
reg add "%D%" /v "SubCommands" /d "" /f >nul 2>&1
reg add "%D%\Shell\01_Claude_GLM" /v "MUIVerb" /d "%GLM_NAME%" /f >nul 2>&1
reg add "%D%\Shell\01_Claude_GLM\command" /ve /d "cmd.exe /c call \"%LAUNCHER_BAT%\" glm.json \"%%1\"" /f >nul 2>&1
reg add "%D%\Shell\02_Claude_Qwen" /v "MUIVerb" /d "%QWEN_NAME%" /f >nul 2>&1
reg add "%D%\Shell\02_Claude_Qwen\command" /ve /d "cmd.exe /c call \"%LAUNCHER_BAT%\" qwen.json \"%%1\"" /f >nul 2>&1
reg add "%D%\Shell\03_Claude_MiniMax" /v "MUIVerb" /d "%MINIMAX_NAME%" /f >nul 2>&1
reg add "%D%\Shell\03_Claude_MiniMax\command" /ve /d "cmd.exe /c call \"%LAUNCHER_BAT%\" minimax.json \"%%1\"" /f >nul 2>&1
reg add "%D%\Shell\04_Claude_Kimi" /v "MUIVerb" /d "%KIMI_NAME%" /f >nul 2>&1
reg add "%D%\Shell\04_Claude_Kimi\command" /ve /d "cmd.exe /c call \"%LAUNCHER_BAT%\" kimi.json \"%%1\"" /f >nul 2>&1
reg add "%D%\Shell\05_Claude_DeepSeek" /v "MUIVerb" /d "%DEEPSEEK_NAME%" /f >nul 2>&1
reg add "%D%\Shell\05_Claude_DeepSeek" /v "CommandFlags" /t REG_DWORD /d 64 /f >nul 2>&1
reg add "%D%\Shell\05_Claude_DeepSeek\command" /ve /d "cmd.exe /c call \"%LAUNCHER_BAT%\" deepseek.json \"%%1\"" /f >nul 2>&1
reg add "%D%\Shell\06_Codex" /v "MUIVerb" /d "%CODEX_NAME%" /f >nul 2>&1
reg add "%D%\Shell\06_Codex\command" /ve /d "cmd.exe /c call \"%LAUNCHER_BAT%\" codex \"%%1\"" /f >nul 2>&1
reg add "%D%\Shell\07_Gemini" /v "MUIVerb" /d "%GEMINI_NAME%" /f >nul 2>&1
reg add "%D%\Shell\07_Gemini\command" /ve /d "cmd.exe /c call \"%LAUNCHER_BAT%\" gemini \"%%1\"" /f >nul 2>&1

:: C. File
set "F=HKEY_CLASSES_ROOT\*\shell\CLICodeMenu"
reg add "%F%" /v "MUIVerb" /d "%MENU_NAME%" /f >nul 2>&1
reg add "%F%" /v "SubCommands" /d "" /f >nul 2>&1
reg add "%F%\Shell\01_Claude_GLM" /v "MUIVerb" /d "%GLM_NAME%" /f >nul 2>&1
reg add "%F%\Shell\01_Claude_GLM\command" /ve /d "cmd.exe /c call \"%LAUNCHER_BAT%\" glm.json \"%%1\"" /f >nul 2>&1
reg add "%F%\Shell\02_Claude_Qwen" /v "MUIVerb" /d "%QWEN_NAME%" /f >nul 2>&1
reg add "%F%\Shell\02_Claude_Qwen\command" /ve /d "cmd.exe /c call \"%LAUNCHER_BAT%\" qwen.json \"%%1\"" /f >nul 2>&1
reg add "%F%\Shell\03_Claude_MiniMax" /v "MUIVerb" /d "%MINIMAX_NAME%" /f >nul 2>&1
reg add "%F%\Shell\03_Claude_MiniMax\command" /ve /d "cmd.exe /c call \"%LAUNCHER_BAT%\" minimax.json \"%%1\"" /f >nul 2>&1
reg add "%F%\Shell\04_Claude_Kimi" /v "MUIVerb" /d "%KIMI_NAME%" /f >nul 2>&1
reg add "%F%\Shell\04_Claude_Kimi\command" /ve /d "cmd.exe /c call \"%LAUNCHER_BAT%\" kimi.json \"%%1\"" /f >nul 2>&1
reg add "%F%\Shell\05_Claude_DeepSeek" /v "MUIVerb" /d "%DEEPSEEK_NAME%" /f >nul 2>&1
reg add "%F%\Shell\05_Claude_DeepSeek" /v "CommandFlags" /t REG_DWORD /d 64 /f >nul 2>&1
reg add "%F%\Shell\05_Claude_DeepSeek\command" /ve /d "cmd.exe /c call \"%LAUNCHER_BAT%\" deepseek.json \"%%1\"" /f >nul 2>&1
reg add "%F%\Shell\06_Codex" /v "MUIVerb" /d "%CODEX_NAME%" /f >nul 2>&1
reg add "%F%\Shell\06_Codex\command" /ve /d "cmd.exe /c call \"%LAUNCHER_BAT%\" codex \"%%1\"" /f >nul 2>&1
reg add "%F%\Shell\07_Gemini" /v "MUIVerb" /d "%GEMINI_NAME%" /f >nul 2>&1
reg add "%F%\Shell\07_Gemini\command" /ve /d "cmd.exe /c call \"%LAUNCHER_BAT%\" gemini \"%%1\"" /f >nul 2>&1

echo   [OK] Registry entries registered
echo.

echo [3/6] Preparing Claude folders...
set "SETTINGS_DIR=%USERPROFILE%\.claude\launchers\.settings"
set "BATS_DIR=%USERPROFILE%\.claude\launchers\.bats"
if not exist "%SETTINGS_DIR%" mkdir "%SETTINGS_DIR%"
if not exist "%BATS_DIR%" mkdir "%BATS_DIR%"

echo [4/6] Checking/Creating settings templates...

if not exist "%SETTINGS_DIR%\deepseek.json" (
    echo   Creating deepseek.json template...
    (
    echo { 
    echo   "env": { 
    echo     "ANTHROPIC_BASE_URL": "https://api.deepseek.com/anthropic",
    echo     "ANTHROPIC_AUTH_TOKEN": "YOUR_API_KEY_HERE",
    echo     "API_TIMEOUT_MS": "3000000",
    echo     "ANTHROPIC_MODEL": "deepseek-chat",
    echo     "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1",
    echo     "ANTHROPIC_DEFAULT_OPUS_MODEL": "deepseek-chat",
    echo     "ANTHROPIC_DEFAULT_SONNET_MODEL": "deepseek-chat",
    echo     "ANTHROPIC_DEFAULT_HAIKU_MODEL": "deepseek-chat"
    echo   }
    echo }
    ) > "%SETTINGS_DIR%\deepseek.json"
) else (echo   Skipped: deepseek.json already exists)

if not exist "%SETTINGS_DIR%\glm.json" (
    echo   Creating glm.json template...
    (
    echo { 
    echo   "env": {
    echo     "ANTHROPIC_BASE_URL": "https://open.bigmodel.cn/api/anthropic",
    echo     "ANTHROPIC_AUTH_TOKEN": "YOUR_API_KEY_HERE",
    echo     "API_TIMEOUT_MS": "3000000",
    echo     "ANTHROPIC_MODEL": "glm-4.7",
    echo     "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1",
    echo     "ANTHROPIC_DEFAULT_OPUS_MODEL": "glm-5.1",
    echo     "ANTHROPIC_DEFAULT_SONNET_MODEL": "glm-5-turbo",
    echo     "ANTHROPIC_DEFAULT_HAIKU_MODEL": "glm-4.7"
    echo   }
    echo }
    ) > "%SETTINGS_DIR%\glm.json"
) else (echo   Skipped: glm.json already exists)

if not exist "%SETTINGS_DIR%\kimi.json" (
    echo   Creating kimi.json template...
    (
    echo {
    echo   "env": {
    echo     "ANTHROPIC_BASE_URL": "https://api.moonshot.cn/anthropic",
    echo     "ANTHROPIC_AUTH_TOKEN": "YOUR_API_KEY_HERE",
    echo     "API_TIMEOUT_MS": "3000000",
    echo     "ANTHROPIC_MODEL": "kimi-k2.5",
    echo     "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1",
    echo     "ANTHROPIC_DEFAULT_OPUS_MODEL": "kimi-k2.5",
    echo     "ANTHROPIC_DEFAULT_SONNET_MODEL": "kimi-k2-thinking",
    echo     "ANTHROPIC_DEFAULT_HAIKU_MODEL": "kimi-linear"
    echo   }
    echo }
    ) > "%SETTINGS_DIR%\kimi.json"
) else (echo   Skipped: kimi.json already exists)

if not exist "%SETTINGS_DIR%\minimax.json" (
    echo   Creating minimax.json template...
    (
    echo {
    echo   "env": {
    echo     "ANTHROPIC_BASE_URL": "https://api.minimaxi.com/anthropic",
    echo     "ANTHROPIC_AUTH_TOKEN": "YOUR_API_KEY_HERE",
    echo     "API_TIMEOUT_MS": "3000000",
    echo     "ANTHROPIC_MODEL": "MiniMax-M2.7",
    echo     "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1",
    echo     "ANTHROPIC_DEFAULT_OPUS_MODEL": "MiniMax-M2.7", 
    echo     "ANTHROPIC_DEFAULT_SONNET_MODEL": "MiniMax-M2.5",
    echo     "ANTHROPIC_DEFAULT_HAIKU_MODEL": "MiniMax-M2"
    echo   }
    echo }
    ) > "%SETTINGS_DIR%\minimax.json"
) else (echo   Skipped: minimax.json already exists)

if not exist "%SETTINGS_DIR%\qwen.json" (
    echo   Creating qwen.json template...
    (
    echo {
    echo   "env": {
    echo     "ANTHROPIC_BASE_URL": "https://coding.dashscope.aliyuncs.com/apps/anthropic",
    echo     "ANTHROPIC_AUTH_TOKEN": "YOUR_API_KEY_HERE",
    echo     "API_TIMEOUT_MS": "3000000",
    echo     "ANTHROPIC_MODEL": "qwen3.5-plus",
    echo     "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1",
    echo     "ANTHROPIC_DEFAULT_OPUS_MODEL": "qwen3.5-plus",
    echo     "ANTHROPIC_DEFAULT_SONNET_MODEL": "qwen3-max-2026-01-23",
    echo     "ANTHROPIC_DEFAULT_HAIKU_MODEL": "qwen3-coder-plus"
    echo   }
    echo }
    ) > "%SETTINGS_DIR%\qwen.json"
) else (echo   Skipped: qwen.json already exists)

echo [5/6] Writing launcher helper BAT...
set "F=%LAUNCHER_BAT%"
echo @echo off> "%F%"
echo chcp 65001 ^>nul>> "%F%"
echo setlocal>> "%F%"
echo title CLI Tools Router>> "%F%"
echo.>> "%F%"
echo if "%%~1"=="" (>> "%F%"
echo     echo Missing command or settings file.>> "%F%"
echo     pause>> "%F%"
echo     exit /b 1>> "%F%"
echo )>> "%F%"
echo.>> "%F%"
echo if "%%~2" NEQ "" (>> "%F%"
echo     if exist "%%~2\" (>> "%F%"
echo         cd /d "%%~2">> "%F%"
echo     ) else (>> "%F%"
echo         cd /d "%%~dp2">> "%F%"
echo     )>> "%F%"
echo )>> "%F%"
echo.>> "%F%"
echo cd ^>"%%USERPROFILE%%\.claude\launchers\.last_cwd">> "%F%"
echo.>> "%F%"
echo if "%%~3" NEQ "" (>> "%F%"
echo     echo [Agent Mode] Executing task automatically...>> "%F%"
echo     if /i "%%~1"=="codex" (>> "%F%"
echo         set "HTTP_PROXY=http://127.0.0.1:7890">> "%F%"
echo         set "HTTPS_PROXY=http://127.0.0.1:7890">> "%F%"
echo         codex --prompt "%%~3" --yes>> "%F%"
echo     ) else if /i "%%~1"=="gemini" (>> "%F%"
echo         set "HTTP_PROXY=http://127.0.0.1:7890">> "%F%"
echo         set "HTTPS_PROXY=http://127.0.0.1:7890">> "%F%"
echo         gemini -p "%%~3" --yolo>> "%F%"
echo     ) else (>> "%F%"
echo         claude --setting-sources project,local --settings "%%USERPROFILE%%\.claude\launchers\.settings\%%~1" -p "%%~3" --dangerously-skip-permissions>> "%F%"
echo     )>> "%F%"
echo ) else (>> "%F%"
echo     if /i "%%~1"=="codex" (>> "%F%"
echo         set "HTTP_PROXY=http://127.0.0.1:7890">> "%F%"
echo         set "HTTPS_PROXY=http://127.0.0.1:7890">> "%F%"
echo         codex>> "%F%"
echo     ) else if /i "%%~1"=="gemini" (>> "%F%"
echo         set "HTTP_PROXY=http://127.0.0.1:7890">> "%F%"
echo         set "HTTPS_PROXY=http://127.0.0.1:7890">> "%F%"
echo         gemini>> "%F%"
echo     ) else (>> "%F%"
echo         claude --setting-sources project,local --settings "%%USERPROFILE%%\.claude\launchers\.settings\%%~1">> "%F%"
echo     )>> "%F%"
echo )>> "%F%"
echo endlocal>> "%F%"

if exist "%LAUNCHER_BAT%" (
    echo   [OK] Launcher BAT created successfully at: %LAUNCHER_BAT%
) else (
    echo   [ERROR] Failed to create Launcher BAT!
    pause
)

echo.
echo [6/6] Refreshing Windows Explorer...
powershell -WindowStyle Hidden -Command "Add-Type -TypeDefinition 'using System; using System.Runtime.InteropServices; public class Refresh { [DllImport(\"shell32.dll\")] public static extern void SHChangeNotify(int wEventId, uint uFlags, IntPtr dwItem1, IntPtr dwItem2); }'; [Refresh]::SHChangeNotify(0x8000000, 0, 0, 0)" 2>nul

echo.
echo ============================================================
echo                    Installation Complete
echo ============================================================
echo.
pause
