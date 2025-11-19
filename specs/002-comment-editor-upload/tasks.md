# 任務清單：社群留言編輯工具（檔案上傳版）

**版本**: 2.0（無需 API 版本）  
**Input**: 設計文件來自 `/specs/002-comment-editor-upload/`  
**前提條件**: plan.md, spec.md

**簡化說明**: 此版本移除所有 API 相關功能，專注於檔案處理和編輯功能，任務數量從 116 個簡化為 58 個

---

## Phase 1: Setup（專案初始化）

**目的**: 建立專案結構和基本配置

- [ ] T001 [P] 建立專案根目錄結構 comment-editor/
- [ ] T002 [P] 初始化 React + TypeScript + Vite 專案
- [ ] T003 [P] 安裝核心依賴（React, Dexie, AG Grid, SheetJS, Papa Parse）
- [ ] T004 [P] 設定 ESLint 和 Prettier
- [ ] T005 [P] 設定 Tailwind CSS
- [ ] T006 [P] 建立 TypeScript 類型定義結構 src/types/
- [ ] T007 [P] 建立 .gitignore
- [ ] T008 [P] 建立 README.md（繁體中文）

---

## Phase 2: Foundation（基礎設施）

**目的**: 核心基礎功能

### IndexedDB 資料層

- [ ] T009 設定 Dexie.js 資料庫 Schema src/services/storage/db.ts
- [ ] T010 [P] 定義 TypeScript 類型（comment.ts, import-batch.ts）src/types/
- [ ] T011 [P] 實作 Comment 資料存取層 src/services/storage/comments-store.ts
- [ ] T012 [P] 實作配額管理模組 src/services/storage/quota-manager.ts
- [ ] T013 [P] 撰寫儲存層單元測試 tests/unit/storage.test.ts

### 核心工具

- [ ] T014 [P] 實作日期解析器（支援多種格式）src/services/utils/date-parser.ts
- [ ] T015 [P] 實作資料驗證器 src/services/utils/validator.ts
- [ ] T016 [P] 實作錯誤處理工具 src/services/utils/error-handler.ts
- [ ] T017 [P] 撰寫工具模組單元測試 tests/unit/utils.test.ts

### 基礎 UI 元件

- [ ] T018 [P] 實作 Button 元件 src/components/common/Button.tsx
- [ ] T019 [P] 實作 Input 元件 src/components/common/Input.tsx
- [ ] T020 [P] 實作 Modal 元件 src/components/common/Modal.tsx
- [ ] T021 [P] 實作 Toast 通知系統 src/components/common/Toast.tsx
- [ ] T022 [P] 實作 ProgressBar 元件 src/components/common/ProgressBar.tsx

**Checkpoint**: 基礎完成 - 可以開始使用者故事實作

---

## Phase 3: User Story 1 - 檔案上傳功能 (Priority: P1) 🎯 MVP

**目標**: 使用者可以上傳 CSV/Excel/JSON 檔案或手動貼上資料

### 測試（TDD）

- [ ] T023 [P] [US1] 撰寫 CSV 解析單元測試 tests/unit/csv-parser.test.ts
- [ ] T024 [P] [US1] 撰寫 Excel 解析單元測試 tests/unit/excel-parser.test.ts
- [ ] T025 [P] [US1] 撰寫 JSON 解析單元測試 tests/unit/json-parser.test.ts
- [ ] T026 [P] [US1] 撰寫匯入流程整合測試 tests/integration/import.spec.ts

### 檔案解析器實作

- [ ] T027 [P] [US1] 實作 CSV 解析器（Papa Parse）src/services/parsers/csv-parser.ts
- [ ] T028 [P] [US1] 實作 Excel 解析器（SheetJS）src/services/parsers/excel-parser.ts
- [ ] T029 [P] [US1] 實作 JSON 解析器 src/services/parsers/json-parser.ts
- [ ] T030 [US1] 實作智能欄位對應邏輯 src/services/parsers/field-mapper.ts
- [ ] T031 [P] [US1] 建立 useFileImport Hook src/hooks/useFileImport.ts

### UI 實作

- [ ] T032 [P] [US1] 實作 FileUploader 元件（拖放 + 選擇檔案）src/components/upload/FileUploader.tsx
- [ ] T033 [P] [US1] 實作 DataPaster 元件（貼上文字資料）src/components/upload/DataPaster.tsx
- [ ] T034 [P] [US1] 實作 ImportProgress 元件（解析進度）src/components/upload/ImportProgress.tsx
- [ ] T035 [P] [US1] 實作 FieldMapper 元件（欄位對應 UI）src/components/upload/FieldMapper.tsx
- [ ] T036 [US1] 實作 Home 頁面整合上傳功能 src/pages/Home.tsx

### 整合與驗證

- [ ] T037 [US1] 整合所有匯入功能
- [ ] T038 [US1] 執行 E2E 測試驗證完整匯入流程
- [ ] T039 [US1] 效能測試：1000 則留言匯入 <3 秒

**Checkpoint**: 使用者可以成功匯入資料並顯示在表格中

---

## Phase 4: User Story 2 - 範例資料載入 (Priority: P2)

**目標**: 提供快速體驗功能的範例資料

- [ ] T040 [P] [US2] 建立範例資料集（100 則多樣化留言）src/data/mock-comments.ts
- [ ] T041 [P] [US2] 實作範例資料載入功能 src/services/data/sample-data-loader.ts
- [ ] T042 [US2] 實作「載入範例資料」按鈕和確認對話框

**Checkpoint**: 使用者可以快速體驗工具

---

## Phase 5: User Story 3 - 線上編輯功能 (Priority: P3)

**目標**: 表格編輯、搜尋、篩選、自訂欄位

### 編輯功能

- [ ] T043 [P] [US3] 實作 CommentsTable（AG Grid 整合）src/components/table/CommentsTable.tsx
- [ ] T044 [P] [US3] 實作 TableToolbar（刪除、搜尋、篩選）src/components/table/TableToolbar.tsx
- [ ] T045 [P] [US3] 實作 SearchFilter 元件 src/components/table/SearchFilter.tsx
- [ ] T046 [US3] 實作刪除確認對話框 src/components/table/DeleteConfirm.tsx

### 自訂欄位

- [ ] T047 [P] [US3] 實作 CustomFieldManager 元件 src/components/table/CustomFieldManager.tsx
- [ ] T048 [US3] 整合自訂欄位到 CommentsTable

### 復原功能

- [ ] T049 [P] [US3] 實作 UndoManager src/services/utils/undo-manager.ts
- [ ] T050 [US3] 實作復原/重做 UI 按鈕

### 整合

- [ ] T051 [US3] 建立 Editor 頁面 src/pages/Editor.tsx
- [ ] T052 [US3] 測試編輯功能

**Checkpoint**: 完整的編輯功能可用

---

## Phase 6: User Story 4 - Excel 匯出 (Priority: P4)

**目標**: 匯出為 Excel，中文無亂碼

- [ ] T053 [P] [US4] 實作 Excel 匯出邏輯（SheetJS）src/services/export/excel-exporter.ts
- [ ] T054 [P] [US4] 實作資料轉換（Comment → Excel 格式）src/services/export/data-transformer.ts
- [ ] T055 [P] [US4] 實作 ExportButton 元件 src/components/export/ExportButton.tsx
- [ ] T056 [US4] 整合匯出功能
- [ ] T057 [US4] 測試繁體中文匯出無亂碼
- [ ] T058 [US4] 效能測試：1000 則匯出 <5 秒

**Checkpoint**: 完整功能閉環（匯入 → 編輯 → 匯出）

---

## Phase 7: Polish & 優化

### 品質保證

- [ ] T059 [P] 驗證程式碼覆蓋率 ≥80%
- [ ] T060 [P] 執行 ESLint 確保零警告
- [ ] T061 [P] 驗證 WCAG 2.1 AA 無障礙合規
- [ ] T062 [P] 執行 Lighthouse CI 驗證效能

### 配額管理

- [ ] T063 [P] 實作 QuotaWarning 元件 src/components/storage/QuotaWarning.tsx
- [ ] T064 [P] 實作 StorageCleanup 清理工具 src/components/storage/StorageCleanup.tsx

### UX 優化

- [ ] T065 [P] 實作鍵盤快捷鍵（Ctrl+Z, Ctrl+F）
- [ ] T066 [P] 新增載入骨架屏
- [ ] T067 [P] 實作錯誤邊界

### 文件

- [ ] T068 [P] 撰寫使用者手冊（繁中）docs/user-guide.md
- [ ] T069 [P] 建立範例檔案（CSV, Excel）public/examples/
- [ ] T070 [P] 更新 README.md

---

## 任務統計

| 階段 | 任務數 | 預估時間 | 可並行 |
|------|-------|---------|--------|
| Phase 1: Setup | 8 | 0.5 天 | 100% |
| Phase 2: Foundation | 14 | 1 天 | ~70% |
| Phase 3: US1 匯入 | 17 | 1.5 天 | ~60% |
| Phase 4: US2 範例 | 3 | 0.5 天 | 100% |
| Phase 5: US3 編輯 | 10 | 1.5 天 | ~60% |
| Phase 6: US4 匯出 | 6 | 1 天 | ~70% |
| Phase 7: Polish | 12 | 1 天 | ~80% |
| **總計** | **70 任務** | **7 天** | **~70%** |

**MVP（P1+P2+P3）**: 39 任務，4 天

---

## 執行策略

### MVP 優先（推薦）

```
Day 1: Setup + Foundation（T001-T022）
Day 2: 檔案解析器（T023-T031）
Day 3: 上傳 UI + 範例資料（T032-T042）
Day 4: 基礎編輯（T043-T046）+ 測試
---
MVP 完成！可匯入、編輯、顯示
```

### 完整功能

```
Day 5: 進階編輯（T047-T052）
Day 6: Excel 匯出（T053-T058）
Day 7: Polish（T059-T070）
---
完整功能！
```

---

**任務清單完成時間**: 2025-11-19  
**總任務數**: 70（vs 原版 116，簡化 40%）  
**預估時程**: 7 天完整，4 天 MVP

🎯 **立即可開始，無需等待 API 審核！**

