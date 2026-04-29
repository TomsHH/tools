@echo off
chcp 65001 >nul
title Uninstall Windows Terminal Split Menu
color 0A

:: Check admin rights
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo ============================================================
echo           Uninstall Windows Terminal Split Menu
echo ============================================================
echo.

:: Define paths
set "SCRIPTS_DIR=%USERPROFILE%\.claude\launchers"
set "PS_SCRIPT=%SCRIPTS_DIR%\SelectAndSplit.ps1"
set "WT_SETTINGS=%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

:: Use PowerShell to remove the hotkey from both actions and keybindings
    powershell -NoProfile -ExecutionPolicy Bypass -Command ^
        "$settingsPath = '%WT_SETTINGS%';" ^
        "$json = Get-Content $settingsPath -Raw | ConvertFrom-Json;" ^
        "if ($null -ne $json.actions) {" ^
        "    if ($json.actions -isnot [System.Array]) { $json.actions = @($json.actions) };" ^
        "    $json.actions = @($json.actions | Where-Object { $_.keys -ne 'ctrl+shift+d' });" ^
        "}" ^
        "if ($null -ne $json.keybindings) {" ^
        "    if ($json.keybindings -isnot [System.Array]) { $json.keybindings = @($json.keybindings) };" ^
        "    $json.keybindings = @($json.keybindings | Where-Object { $_.keys -ne 'ctrl+shift+d' });" ^
        "}" ^
        "$json | ConvertTo-Json -Depth 10 | Set-Content $settingsPath -Encoding UTF8;" ^
        "Write-Host '   [OK] Hotkey Ctrl+Shift+D removed from settings.json';"
echo.

echo [2/3] Deleting selection script...
if exist "%PS_SCRIPT%" (
    del /F /Q "%PS_SCRIPT%" >nul 2>&1
    echo   [OK] SelectAndSplit.ps1 deleted
) else (
    echo   [SKIP] Script file not found
)
echo.

echo [3/3] Finalizing...
echo   [OK] Uninstallation complete
echo.

echo ============================================================
echo                    Uninstallation Successful!
echo ============================================================
echo.
echo   Please restart Windows Terminal for changes to take effect.
echo.
pause
