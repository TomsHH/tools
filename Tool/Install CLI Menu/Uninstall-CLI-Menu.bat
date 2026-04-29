@echo off
chcp 65001 >nul
title Uninstall CLI Code Context Menu

:: Check admin rights
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo ==========================================
echo    Uninstall CLI Code Context Menu
echo ==========================================
echo.

echo Removing menu entries...

:: Remove old name if exists
reg delete "HKEY_CLASSES_ROOT\Directory\Background\shell\ClaudeCodeMenu" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\Directory\shell\ClaudeCodeMenu" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\*\shell\ClaudeCodeMenu" /f >nul 2>&1

:: Remove new name
reg delete "HKEY_CLASSES_ROOT\Directory\Background\shell\CLICodeMenu" /f >nul 2>&1
if %errorlevel% equ 0 (echo   [OK] Background menu removed)

reg delete "HKEY_CLASSES_ROOT\Directory\shell\CLICodeMenu" /f >nul 2>&1
if %errorlevel% equ 0 (echo   [OK] Folder menu removed)

reg delete "HKEY_CLASSES_ROOT\*\shell\CLICodeMenu" /f >nul 2>&1
if %errorlevel% equ 0 (echo   [OK] File menu removed)

:: Remove all generated configurations and scripts
echo.
echo Cleaning up launcher configurations and scripts...
if exist "%USERPROFILE%\.claude\launchers" (
    rmdir /s /q "%USERPROFILE%\.claude\launchers" >nul 2>&1
    if %errorlevel% equ 0 (
        echo   [OK] Launcher directory removed
    ) else (
        echo   [Wait] Directory is busy, some files may remain.
    )
) else (
    echo   [Skip] Launcher directory already removed or not found.
)

:: Notify Windows
echo.
echo Notifying Windows of changes...
powershell -WindowStyle Hidden -Command "Add-Type -TypeDefinition 'using System; using System.Runtime.InteropServices; public class Refresh { [DllImport(\"shell32.dll\")] public static extern void SHChangeNotify(int wEventId, uint uFlags, IntPtr dwItem1, IntPtr dwItem2); }'; [Refresh]::SHChangeNotify(0x8000000, 0, 0, 0)" 2>nul

echo.
echo ==========================================
echo    Uninstallation Complete!
echo ==========================================
echo.
pause
