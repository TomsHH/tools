# SelectAndSplit.ps1
# Windows Terminal Split Pane Launcher
# Select split mode and AI profile, then launch CLI in split pane

# Console encoding
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# AI Profile configurations
$Configs = @(
    @{Name="GLM"; Config="glm.json"; Color="Green"},
    @{Name="Qwen"; Config="qwen.json"; Color="Blue"},
    @{Name="DeepSeek"; Config="deepseek.json"; Color="Magenta"},
    @{Name="Kimi"; Config="kimi.json"; Color="Yellow"},
    @{Name="MiniMax"; Config="minimax.json"; Color="Cyan"},
    @{Name="Codex"; Config="codex"; Color="DarkYellow"},
    @{Name="Gemini"; Config="gemini"; Color="DarkCyan"}
)

# Launcher path
$LauncherBat = "$env:USERPROFILE\.claude\launchers\.bats\Launch Claude Code Command.bat"

# Display menu
Clear-Host
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "    Windows Terminal Split Launcher    " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Split mode selection
Write-Host "[Split Mode]" -ForegroundColor White
Write-Host "  [H] Horizontal split" -ForegroundColor Gray
Write-Host "  [V] Vertical split" -ForegroundColor Gray
Write-Host ""

# Profile selection
Write-Host "[AI Profile]" -ForegroundColor White
for ($i = 0; $i -lt $Configs.Count; $i++) {
    $config = $Configs[$i]
    $prefix = if ($i -lt 9) { "  [$($i+1)]" } else { " [$($i+1)]" }
    Write-Host "$prefix $($config.Name)" -ForegroundColor $config.Color
}
Write-Host ""

# Get user input
$splitMode = Read-Host "Split mode (H/V)"
$choice = Read-Host "Profile number (1-$($Configs.Count))"

# Validate split mode
$splitMode = $splitMode.ToUpper()
if ($splitMode -ne "H" -and $splitMode -ne "V") {
    $splitMode = "H"
}

# Validate profile number
try {
    $choiceIndex = [int]$choice - 1
    if ($choiceIndex -lt 0 -or $choiceIndex -ge $Configs.Count) {
        Write-Host "Invalid selection, using default GLM" -ForegroundColor Yellow
        $choiceIndex = 0
    }
} catch {
    Write-Host "Invalid input, using default GLM" -ForegroundColor Yellow
    $choiceIndex = 0
}

# Get selected config
$selectedConfig = $Configs[$choiceIndex]
$configName = $selectedConfig.Config
$configDisplay = $selectedConfig.Name

Write-Host ""
Write-Host "Split: $splitMode | Profile: $configDisplay" -ForegroundColor Green
Write-Host "Launching..." -ForegroundColor Gray

# Get current path
# 优先从跟踪文件读取（解决从 CLI 窗口分屏时 startingDirectory "." 不生效的问题）
$currentPath = $PWD.Path
$cwdFile = "$env:USERPROFILE\.claude\launchers\.last_cwd"
if (Test-Path $cwdFile) {
    $trackedPath = (Get-Content $cwdFile -Raw).Trim()
    if ($trackedPath -and (Test-Path $trackedPath -PathType Container)) {
        $currentPath = $trackedPath
    }
}

# Split argument
$splitArg = if ($splitMode -eq "V") { "-V" } else { "-H" }

# Create a temp batch file to avoid path escaping issues
$tempBat = "$env:TEMP\split_launch_$([Guid]::NewGuid().ToString()).bat"
$batContent = "@echo off`ncall `"$LauncherBat`" $configName `"$currentPath`""
Set-Content -Path $tempBat -Value $batContent -Encoding ASCII

# Move focus left to the original pane (menu is on the right side)
# Then split the original pane to launch CLI
& wt -w 0 move-focus left `; split-pane $splitArg -d "$currentPath" -p "Command Prompt" cmd /c $tempBat

# Close this menu pane
exit