# 設置自動 Commit 功能
# 功能：配置專案以支援自動提交

. "$PSScriptRoot\common.ps1"

Write-ColorOutput "🔧 設置自動 Commit 功能..." "Cyan"

# 檢查 Git
if (-not (Test-Path ".git")) {
    Write-ColorOutput "❌ 錯誤：當前目錄不是 Git 倉庫" "Red"
    exit 1
}

# 建立別名腳本
$aliasScript = @"
# 快速自動提交別名

function Commit-Auto {
    param([string]`$Message = "")
    
    if ([string]::IsNullOrWhiteSpace(`$Message)) {
        & .\.specify\scripts\powershell\auto-commit.ps1
    } else {
        & .\.specify\scripts\powershell\auto-commit.ps1 -Message `$Message
    }
}

# 設置別名
Set-Alias -Name "ac" -Value Commit-Auto
Set-Alias -Name "auto-commit" -Value Commit-Auto

Write-Host "✅ 自動 Commit 別名已載入" -ForegroundColor Green
Write-Host "使用方式：" -ForegroundColor Cyan
Write-Host "  ac                    - 自動生成 message 並提交" -ForegroundColor White
Write-Host "  ac 'your message'     - 使用自訂 message 提交" -ForegroundColor White
Write-Host "  auto-commit           - 同 ac" -ForegroundColor White
"@

$profileDir = Split-Path $PROFILE -Parent
if (-not (Test-Path $profileDir)) {
    New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
}

# 檢查 PowerShell Profile
if (Test-Path $PROFILE) {
    $profileContent = Get-Content $PROFILE -Raw
    if ($profileContent -notmatch "auto-commit") {
        Add-Content -Path $PROFILE -Value "`n# Auto-commit aliases`n$aliasScript"
        Write-ColorOutput "✅ 已添加別名到 PowerShell Profile" "Green"
    } else {
        Write-ColorOutput "ℹ️  PowerShell Profile 中已存在 auto-commit 配置" "Yellow"
    }
} else {
    Set-Content -Path $PROFILE -Value $aliasScript
    Write-ColorOutput "✅ 已創建 PowerShell Profile 並添加別名" "Green"
}

# 建立本地快捷腳本
$shortcutScript = @"
# 快速執行自動提交
param([string]`$Message = "")

if ([string]::IsNullOrWhiteSpace(`$Message)) {
    & .\.specify\scripts\powershell\auto-commit.ps1
} else {
    & .\.specify\scripts\powershell\auto-commit.ps1 -Message `$Message
}
"@

Set-Content -Path "commit.ps1" -Value $shortcutScript
Write-ColorOutput "✅ 已創建快捷腳本: commit.ps1" "Green"

# 建立 .gitignore（如果不存在）
if (-not (Test-Path ".gitignore")) {
    Set-Content -Path ".gitignore" -Value @"
# Dependencies
node_modules/
vendor/

# Build outputs
dist/
build/
out/
*.exe
*.dll
*.so
*.dylib

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db

# Logs
*.log
logs/

# Environment
.env
.env.local
"@
    Write-ColorOutput "✅ 已創建 .gitignore" "Green"
}

Write-ColorOutput "`n🎉 設置完成！" "Green"
Write-ColorOutput "`n使用方式：" "Cyan"
Write-ColorOutput "  1. 重新載入 PowerShell 或執行: . `$PROFILE" "White"
Write-ColorOutput "  2. 在專案根目錄執行: ac" "White"
Write-ColorOutput "  3. 或使用: .\commit.ps1" "White"
Write-ColorOutput "  4. 自訂訊息: ac 'your commit message'" "White"
Write-ColorOutput "`n💡 提示：每次儲存檔案後執行 'ac' 即可自動提交" "Yellow"

