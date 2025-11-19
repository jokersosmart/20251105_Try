# 中文化與自動提交設定指南

本文件說明如何使用專案的繁體中文化功能和自動 Git 提交機制。

---

## 📋 目錄

1. [繁體中文化設定](#繁體中文化設定)
2. [自動提交功能](#自動提交功能)
3. [對話歷史記錄](#對話歷史記錄)
4. [快速開始](#快速開始)

---

## 🌏 繁體中文化設定

### 憲章要求

根據專案憲章第五項原則（v1.1.0），所有規格書、計劃和面向用戶的文檔必須使用繁體中文。

### 已中文化的組件

✅ **Agent 檔案**（已更新）：
- `.github/agents/speckit.specify.agent.md` - 規格書生成
- `.github/agents/speckit.plan.agent.md` - 計劃生成
- `.github/agents/speckit.tasks.agent.md` - 任務生成

✅ **模板檔案**（已包含中文要求）：
- `.specify/templates/spec-template.md`
- `.specify/templates/plan-template.md`
- `.specify/templates/tasks-template.md`

✅ **憲章文件**：
- `.specify/memory/constitution.md` - 包含完整的繁體中文要求

### 語言使用範圍

| 內容類型 | 語言要求 | 範例 |
|---------|---------|------|
| 功能規格書 | ✅ 繁體中文 | `/specs/*/spec.md` |
| 實作計劃 | ✅ 繁體中文 | `/specs/*/plan.md` |
| 使用者故事 | ✅ 繁體中文 | 規格書內的場景描述 |
| UI 文字 | ✅ 繁體中文 | 按鈕、標籤、訊息 |
| 錯誤訊息 | ✅ 繁體中文 | 所有用戶可見的錯誤 |
| 程式碼註解 | ⚠️ 建議英文 | 方便國際協作 |
| 變數名稱 | ⚠️ 必須英文 | 遵循編碼標準 |
| API 規格 | ⚠️ 保持英文 | OpenAPI/GraphQL schema |

---

## 🔄 自動提交功能

### 功能說明

自動提交功能可以：
- 🔍 自動檢測檔案變更
- 📝 智能生成 commit message
- 💾 自動執行 git add 和 git commit
- 📋 更新 History.md 記錄

### 安裝步驟

#### 1. 執行安裝腳本

```powershell
# 在專案根目錄執行
.\.specify\scripts\powershell\setup-auto-commit.ps1
```

這個腳本會：
- ✅ 創建 PowerShell 別名（`ac` 和 `auto-commit`）
- ✅ 更新您的 PowerShell Profile
- ✅ 創建快捷腳本 `commit.ps1`
- ✅ 建立 `.gitignore`（如果不存在）

#### 2. 重新載入 PowerShell Profile

```powershell
# 方法 1: 重新載入 Profile
. $PROFILE

# 方法 2: 重新啟動 PowerShell 終端
```

### 使用方式

#### 方式 1: 使用別名（最簡單）

```powershell
# 自動生成 commit message
ac

# 使用自訂 commit message
ac "feat: 新增使用者登入功能"
```

#### 方式 2: 使用快捷腳本

```powershell
# 自動生成 commit message
.\commit.ps1

# 使用自訂 commit message
.\commit.ps1 "docs: 更新 README"
```

#### 方式 3: 直接執行腳本

```powershell
# 自動生成 commit message
.\.specify\scripts\powershell\auto-commit.ps1

# 使用自訂 commit message
.\.specify\scripts\powershell\auto-commit.ps1 -Message "fix: 修正登入錯誤"

# Dry Run 模式（只顯示不執行）
.\.specify\scripts\powershell\auto-commit.ps1 -DryRun
```

### Commit Message 自動生成規則

腳本會根據變更類型智能生成 commit message：

| 變更類型 | Commit 類型 | 範例 |
|---------|------------|------|
| 新增檔案 | `feat` | `feat: add new files` |
| 修改 `.md` 檔案 | `docs` | `docs: update documentation` |
| 修改憲章 | `docs(constitution)` | `docs(constitution): update project constitution` |
| 修改模板 | `docs(templates)` | `docs(templates): update templates` |
| 修改 `.ps1` 腳本 | `build(scripts)` | `build(scripts): update scripts` |
| 刪除檔案 | `refactor` | `refactor: remove files` |
| 混合變更 | `chore` | `chore: update files` |

### 自動更新 History.md

每次成功提交後，腳本會自動：
1. 在 `History.md` 中記錄 commit hash
2. 記錄 commit message
3. 記錄時間戳
4. 自動提交 History.md 的更新

---

## 📝 對話歷史記錄

### History.md 說明

`History.md` 檔案用於記錄：
- 所有與 AI 助手的重要對話
- 使用的 Prompt 指令
- 執行的操作和變更
- Commit 記錄

### 手動更新 History.md

當您進行重要的 AI 對話時，請更新 `History.md`：

```markdown
### 會話 X: [簡短描述]

**Prompt**: 
```
[您使用的完整 prompt]
```

**執行內容**:
- [主要操作 1]
- [主要操作 2]

**變更檔案**:
- `path/to/file` (新建/更新/刪除)

**Commit**: [commit hash 或 "尚未提交"]
```

### 查看歷史記錄

```powershell
# 查看 History.md
cat History.md

# 在編輯器中打開
code History.md
```

---

## 🚀 快速開始

### 完整工作流程

1. **初始設定**（僅需一次）：
   ```powershell
   # 執行自動提交設定
   .\.specify\scripts\powershell\setup-auto-commit.ps1
   
   # 重新載入 Profile
   . $PROFILE
   ```

2. **日常使用**：
   ```powershell
   # 1. 進行檔案修改...
   
   # 2. 使用 AI 生成規格書（會自動輸出繁體中文）
   # 在 IDE 中使用 @speckit.specify.agent.md
   
   # 3. 檢查變更
   git status
   
   # 4. 自動提交
   ac
   
   # 5. 推送到遠端（可選）
   git push
   ```

3. **記錄對話**（建議）：
   ```powershell
   # 在 History.md 中記錄重要的 AI 對話
   code History.md
   # 手動添加會話記錄...
   
   # 再次提交
   ac "docs: 更新對話歷史"
   ```

### 常見場景

#### 場景 1: 創建新功能規格

```powershell
# 使用 AI 創建規格（自動繁體中文）
# @speckit.specify.agent.md 新增使用者登入功能

# 自動提交生成的規格
ac "docs: 新增使用者登入功能規格書"
```

#### 場景 2: 更新憲章

```powershell
# 使用 AI 更新憲章
# @speckit.constitution.agent.md 添加新原則...

# 自動提交（會自動識別為憲章更新）
ac

# 推送
git push
```

#### 場景 3: 批次更新多個檔案

```powershell
# 進行多個檔案修改...

# 使用 Dry Run 預覽
.\.specify\scripts\powershell\auto-commit.ps1 -DryRun

# 確認無誤後執行
ac
```

---

## ⚙️ 進階設定

### 自訂 Commit Message 格式

編輯 `.specify/scripts/powershell/auto-commit.ps1` 來自訂 commit message 生成邏輯。

### 設定 Git Hook（自動觸發）

如果您想在每次儲存時自動提交，可以設定 Git hook：

```powershell
# 創建 post-save hook（需要額外工具）
# 注意：這可能會產生大量 commits，請謹慎使用
```

### 整合到 CI/CD

自動提交腳本可以整合到 CI/CD 流程中：

```yaml
# .github/workflows/auto-commit.yml
name: Auto Commit
on:
  schedule:
    - cron: '0 * * * *'  # 每小時執行
  workflow_dispatch:

jobs:
  commit:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Auto Commit
        run: |
          # 執行自動提交邏輯
```

---

## ❓ 常見問題

### Q: 為什麼 `ac` 命令無法使用？

**A**: 請確保：
1. 已執行 `setup-auto-commit.ps1`
2. 已重新載入 Profile：`. $PROFILE`
3. PowerShell 允許執行腳本：`Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned`

### Q: 如何避免自動生成的 commit message？

**A**: 總是提供自訂 message：
```powershell
ac "你的自訂訊息"
```

### Q: AI 沒有輸出繁體中文怎麼辦？

**A**: 確保：
1. 憲章已更新到 v1.1.0
2. Agent 檔案已包含語言要求
3. 在 Prompt 中明確指定「使用繁體中文」

### Q: 可以暫時停用自動提交嗎？

**A**: 是的，只需不執行 `ac` 命令，手動使用 `git add` 和 `git commit`。

---

## 📚 相關文件

- [`History.md`](./History.md) - 對話歷史記錄
- [`.specify/memory/constitution.md`](./.specify/memory/constitution.md) - 專案憲章
- [`.specify/scripts/powershell/auto-commit.ps1`](./.specify/scripts/powershell/auto-commit.ps1) - 自動提交腳本

---

## 🤝 支援

如有問題或建議，請：
1. 查看 `History.md` 中的類似案例
2. 檢查憲章文件
3. 提交 Issue 或 Pull Request

---

**最後更新**: 2025-11-19  
**版本**: 1.0.0

