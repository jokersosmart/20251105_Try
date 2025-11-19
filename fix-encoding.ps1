# 一鍵修復 PowerShell 中文亂碼問題

Write-Host "`n" -NoNewline
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host "   PowerShell 中文編碼修復工具" -ForegroundColor Cyan
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host ""

# 1. 設定 Git 編碼
Write-Host "[1/4] 設定 Git 編碼配置..." -ForegroundColor Yellow
git config --global core.quotepath false
git config --global i18n.commitencoding utf-8
git config --global i18n.logoutputencoding utf-8
Write-Host "      Git 編碼設定完成" -ForegroundColor Green

# 2. 設定當前會話編碼
Write-Host "`n[2/4] 設定當前 PowerShell 會話編碼..." -ForegroundColor Yellow
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$global:OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 | Out-Null
Write-Host "      當前會話編碼已設為 UTF-8" -ForegroundColor Green

# 3. 更新 PowerShell Profile
Write-Host "`n[3/4] 更新 PowerShell Profile..." -ForegroundColor Yellow

$utf8Header = @"

# ========================================
# 編碼設定（解決中文亂碼問題）
# ========================================
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
`$OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 | Out-Null

"@

if (Test-Path $PROFILE) {
    # 備份
    if (-not (Test-Path "$PROFILE.backup")) {
        Copy-Item $PROFILE "$PROFILE.backup" -Force
        Write-Host "      已備份 Profile 到: $PROFILE.backup" -ForegroundColor Gray
    }
    
    $profileContent = Get-Content $PROFILE -Raw -Encoding UTF8
    
    if ($profileContent -notmatch "# 編碼設定（解決中文亂碼問題）") {
        # 移除舊的編碼設定（如果存在）
        $profileContent = $profileContent -replace "# Fix Chinese character encoding[\s\S]*?\n\n", ""
        $profileContent = $profileContent -replace "\[Console\]::OutputEncoding[\s\S]*?chcp 65001.*?\n", ""
        
        # 在檔案開頭插入新的編碼設定
        $newContent = $utf8Header.TrimStart() + "`n" + $profileContent.TrimStart()
        Set-Content -Path $PROFILE -Value $newContent -Encoding UTF8
        Write-Host "      PowerShell Profile 已更新" -ForegroundColor Green
    } else {
        Write-Host "      PowerShell Profile 已包含編碼設定" -ForegroundColor Gray
    }
} else {
    # 建立新 Profile
    $profileDir = Split-Path $PROFILE -Parent
    if (-not (Test-Path $profileDir)) {
        New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
    }
    Set-Content -Path $PROFILE -Value $utf8Header -Encoding UTF8
    Write-Host "      PowerShell Profile 已建立" -ForegroundColor Green
}

# 4. 測試中文顯示
Write-Host "`n[4/4] 測試中文顯示..." -ForegroundColor Yellow
Write-Host ""
Write-Host "      測試文字：你好，世界！" -ForegroundColor White
Write-Host "      測試文字：繁體中文顯示測試" -ForegroundColor White
Write-Host "      測試文字：Git 推送成功！" -ForegroundColor White
Write-Host ""

# 5. 驗證設定
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host "   設定驗證" -ForegroundColor Cyan
Write-Host "================================================================" -ForegroundColor Cyan

$gitQuotePath = git config --global core.quotepath
$gitCommitEnc = git config --global i18n.commitencoding
$gitLogEnc = git config --global i18n.logoutputencoding

Write-Host ""
Write-Host "Git 設定:" -ForegroundColor Yellow
Write-Host "  core.quotepath:         $gitQuotePath" -ForegroundColor White
Write-Host "  i18n.commitencoding:    $gitCommitEnc" -ForegroundColor White
Write-Host "  i18n.logoutputencoding: $gitLogEnc" -ForegroundColor White

Write-Host ""
Write-Host "PowerShell 設定:" -ForegroundColor Yellow
Write-Host "  Console Encoding:       $([Console]::OutputEncoding.EncodingName)" -ForegroundColor White
Write-Host "  Output Encoding:        $($OutputEncoding.EncodingName)" -ForegroundColor White

# 完成
Write-Host ""
Write-Host "================================================================" -ForegroundColor Green
Write-Host "   修復完成！" -ForegroundColor Green
Write-Host "================================================================" -ForegroundColor Green
Write-Host ""
Write-Host "重要提醒：" -ForegroundColor Yellow
Write-Host "  1. 請關閉此 PowerShell 視窗" -ForegroundColor White
Write-Host "  2. 開啟新的 PowerShell 視窗" -ForegroundColor White
Write-Host "  3. 編碼設定將自動載入" -ForegroundColor White
Write-Host ""
Write-Host "驗證方式：" -ForegroundColor Yellow
Write-Host "  執行: git status" -ForegroundColor White
Write-Host "  或: git log --oneline -3" -ForegroundColor White
Write-Host "  中文應該正常顯示" -ForegroundColor White
Write-Host ""

