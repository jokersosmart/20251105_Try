# 自動 Commit 腳本
# 功能：檢測變更並自動提交到 Git

param(
    [string]$Message = "",
    [switch]$DryRun = $false
)

# 引入共用函數
. "$PSScriptRoot\common.ps1"

Write-ColorOutput "🔍 檢查 Git 狀態..." "Cyan"

# 檢查是否在 Git 倉庫中
if (-not (Test-Path ".git")) {
    Write-ColorOutput "❌ 錯誤：當前目錄不是 Git 倉庫" "Red"
    exit 1
}

# 檢查是否有變更
$status = git status --porcelain
if ([string]::IsNullOrWhiteSpace($status)) {
    Write-ColorOutput "✅ 沒有需要提交的變更" "Green"
    exit 0
}

Write-ColorOutput "`n📝 發現以下變更：" "Yellow"
git status --short

# 如果是 DryRun 模式，只顯示會做什麼
if ($DryRun) {
    Write-ColorOutput "`n🔍 DryRun 模式 - 不會實際提交" "Cyan"
    if ([string]::IsNullOrWhiteSpace($Message)) {
        Write-ColorOutput "將使用自動生成的 commit message" "Yellow"
    } else {
        Write-ColorOutput "將使用 message: $Message" "Yellow"
    }
    exit 0
}

# 添加所有變更
Write-ColorOutput "`n➕ 添加所有變更到暫存區..." "Cyan"
git add -A

# 生成 commit message（如果沒有提供）
if ([string]::IsNullOrWhiteSpace($Message)) {
    # 分析變更類型
    $newFiles = @(git diff --cached --name-only --diff-filter=A)
    $modifiedFiles = @(git diff --cached --name-only --diff-filter=M)
    $deletedFiles = @(git diff --cached --name-only --diff-filter=D)
    
    $commitType = "chore"
    $scope = ""
    $description = "update files"
    
    # 智能判斷 commit 類型
    if ($newFiles.Count -gt 0 -and $modifiedFiles.Count -eq 0 -and $deletedFiles.Count -eq 0) {
        $commitType = "feat"
        $description = "add new files"
    } elseif ($deletedFiles.Count -gt 0) {
        $commitType = "refactor"
        $description = "remove files"
    } elseif ($modifiedFiles -match "\.md$") {
        $commitType = "docs"
        $description = "update documentation"
    } elseif ($modifiedFiles -match "constitution\.md") {
        $commitType = "docs"
        $scope = "constitution"
        $description = "update project constitution"
    } elseif ($modifiedFiles -match "template") {
        $commitType = "docs"
        $scope = "templates"
        $description = "update templates"
    } elseif ($modifiedFiles -match "\.ps1$") {
        $commitType = "build"
        $scope = "scripts"
        $description = "update scripts"
    }
    
    # 構建詳細的 commit message
    $detailLines = @()
    if ($newFiles.Count -gt 0) {
        $detailLines += "`n新增檔案:"
        $newFiles | ForEach-Object { $detailLines += "- $_" }
    }
    if ($modifiedFiles.Count -gt 0) {
        $detailLines += "`n修改檔案:"
        $modifiedFiles | ForEach-Object { $detailLines += "- $_" }
    }
    if ($deletedFiles.Count -gt 0) {
        $detailLines += "`n刪除檔案:"
        $deletedFiles | ForEach-Object { $detailLines += "- $_" }
    }
    
    if ([string]::IsNullOrWhiteSpace($scope)) {
        $Message = "$commitType`: $description"
    } else {
        $Message = "$commitType($scope): $description"
    }
    
    if ($detailLines.Count -gt 0) {
        $Message += $detailLines -join "`n"
    }
    
    Write-ColorOutput "`n📋 自動生成的 Commit Message:" "Cyan"
    Write-ColorOutput $Message "White"
}

# 執行 commit
Write-ColorOutput "`n💾 提交變更..." "Cyan"
try {
    git commit -m $Message
    
    $commitHash = git rev-parse --short HEAD
    Write-ColorOutput "`n✅ 成功提交！Commit Hash: $commitHash" "Green"
    
    # 更新 History.md（如果存在）
    if (Test-Path "History.md") {
        Write-ColorOutput "`n📝 更新 History.md..." "Cyan"
        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        $historyEntry = "`n### 自動提交 - $timestamp`n`n**Commit Hash**: $commitHash`n**Message**: `n``````n$Message`n```````n"
        
        # 在 History.md 的適當位置插入（在 ## 使用說明 之前）
        $historyContent = Get-Content "History.md" -Raw
        if ($historyContent -match "(---\s*\r?\n\r?\n## 使用說明)") {
            $historyContent = $historyContent -replace "(---\s*\r?\n\r?\n## 使用說明)", "$historyEntry`n`$1"
            Set-Content "History.md" $historyContent -NoNewline
            
            # 提交 History.md 的更新
            git add History.md
            git commit -m "docs: update History.md with commit $commitHash" --no-verify
            Write-ColorOutput "✅ History.md 已更新並提交" "Green"
        }
    }
    
    Write-ColorOutput "`n🎉 所有操作完成！" "Green"
    
} catch {
    Write-ColorOutput "`n❌ 提交失敗: $_" "Red"
    exit 1
}

