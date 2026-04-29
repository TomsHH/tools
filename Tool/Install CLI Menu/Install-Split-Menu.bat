@echo off
chcp 65001 >nul
title Install Windows Terminal Split Menu
color 0A

:: Check admin rights
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo ============================================================
echo            Install Windows Terminal Split Menu
echo ============================================================
echo.
echo   Hotkey: Ctrl+Shift+D
echo   Function: Split Pane and Select AI Profile to launch CLI
echo.
echo ============================================================
echo.

:: Define paths
set "SCRIPTS_DIR=%USERPROFILE%\.claude\launchers"
set "PS_SCRIPT=%SCRIPTS_DIR%\SelectAndSplit.ps1"
set "WT_SETTINGS=%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

echo [1/4] Preparing script directory...
if not exist "%SCRIPTS_DIR%" mkdir "%SCRIPTS_DIR%" >nul 2>&1
echo   [OK] Directory ready
echo.

echo [2/4] Copying selection script...
set "SOURCE_PS=%~dp0SelectAndSplit.ps1"
if exist "%SOURCE_PS%" (
    copy /Y "%SOURCE_PS%" "%PS_SCRIPT%" >nul 2>&1
    echo   [OK] SelectAndSplit.ps1 copied to user directory
) else (
    echo   [ERROR] Source script not found: %SOURCE_PS%
    pause
    exit /b 1
)
echo.

echo [3/4] Configuring Windows Terminal hotkey...
if not exist "%WT_SETTINGS%" (
    echo   [ERROR] Windows Terminal settings.json not found
    echo   Please ensure Windows Terminal is installed.
    pause
    exit /b 1
)

:: Use PowerShell to modify settings.json
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$settingsPath = '%WT_SETTINGS%';" ^
    "$scriptPath = '%PS_SCRIPT%';" ^
    "$json = Get-Content $settingsPath -Raw | ConvertFrom-Json;" ^
    "$newAction = @{ command = @{ action = 'splitPane'; split = 'vertical'; size = 0.25; startingDirectory = '.'; commandline = ('powershell -NoProfile -ExecutionPolicy Bypass -File \"' + $scriptPath + '\"') }; keys = 'ctrl+shift+d' };" ^
    "if ($null -eq $json.actions) { $json | Add-Member -MemberType NoteProperty -Name 'actions' -Value @() -Force };" ^
    "if ($json.actions -isnot [System.Array]) { $json.actions = @($json.actions) };" ^
    "$json.actions = @($json.actions | Where-Object { $_.keys -ne 'ctrl+shift+d' });" ^
    "$json.actions += $newAction;" ^
    "if ($null -ne $json.keybindings) { $json.keybindings = @($json.keybindings | Where-Object { $_.keys -ne 'ctrl+shift+d' }) };" ^
    "$json | ConvertTo-Json -Depth 10 | Set-Content $settingsPath -Encoding UTF8;" ^
    "Write-Host '   [OK] Hotkey Ctrl+Shift+D added to settings.json';"

echo.

echo [4/4] Refreshing configuration...
echo   [OK] Installation complete
echo.

echo ============================================================
echo                    Installation Successful!
echo ============================================================
echo.
echo   Usage:
echo   1. Restart Windows Terminal (or open a new tab).
echo   2. Press Ctrl+Shift+D to trigger the split selection menu.
echo   3. Choose split mode (H=Horizontal, V=Vertical).
echo   4. Select AI Profile (1-7).
echo   5. A new CLI terminal will launch as a split in your current pane.
echo.
echo ============================================================
pause
