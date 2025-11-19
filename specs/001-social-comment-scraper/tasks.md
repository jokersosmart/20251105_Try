# 任務清單：社群留言爬蟲工具

**Input**: 設計文件來自 `/specs/001-social-comment-scraper/`  
**前提條件**: plan.md（必須）, spec.md（必須）, research.md, data-model.md, contracts/

**測試**: 根據憲章測試標準，所有使用者故事需要契約、整合、單元測試

**組織方式**: 任務按使用者故事分組，以支援獨立實作和測試

---

## 格式說明: `[ID] [P?] [Story] 描述`

- **[P]**: 可並行執行（不同檔案，無依賴）
- **[Story]**: 所屬使用者故事（US1, US2, US3, US4）
- 包含精確的檔案路徑

---

## 路徑慣例

本專案採用 Web 應用程式結構：
- **前端**: `frontend/src/`
- **後端**: `api/`
- **測試**: `frontend/tests/`, `api/_tests/`

---

## Phase 1: Setup（專案初始化）

**目的**: 建立專案結構和基本配置

- [ ] T001 [P] 建立專案根目錄結構（frontend/, api/, docs/）
- [ ] T002 [P] 初始化前端 React + TypeScript + Vite 專案在 frontend/
- [ ] T003 [P] 初始化 Vercel Serverless Functions 在 api/
- [ ] T004 [P] 設定 ESLint 和 Prettier 配置在 frontend/
- [ ] T005 [P] 設定 Tailwind CSS 在 frontend/
- [ ] T006 [P] 建立 TypeScript 類型定義檔案結構 frontend/src/types/
- [ ] T007 [P] 設定環境變數範本 .env.example
- [ ] T008 [P] 建立 vercel.json 部署設定
- [ ] T009 [P] 設定 Git hooks（Husky + lint-staged）
- [ ] T010 [P] 建立 README.md 專案說明（繁體中文）

---

## Phase 2: Foundational（阻擋性前置基礎）

**目的**: 核心基礎設施，所有使用者故事的依賴

**⚠️ 關鍵**: 此階段完成前，任何使用者故事都無法開始

### 後端 API 代理層

- [ ] T011 [P] 實作 Token 管理模組 api/_lib/token-manager.ts
- [ ] T012 [P] 實作速率限制模組（Token Bucket）api/_lib/rate-limiter.ts
- [ ] T013 [P] 實作錯誤映射模組（API 錯誤→繁中）api/_lib/error-mapper.ts
- [ ] T014 實作 Instagram API 代理端點 api/instagram.ts（依賴 T011-T013）
- [ ] T015 實作 Facebook API 代理端點 api/facebook.ts（依賴 T011-T013）
- [ ] T016 [P] 實作健康檢查端點 api/health.ts
- [ ] T017 [P] 撰寫後端 API 單元測試 api/_tests/api.test.ts

### IndexedDB 資料層

- [ ] T018 設定 Dexie.js 資料庫 Schema frontend/src/services/storage/db.ts
- [ ] T019 [P] 定義 TypeScript 類型 frontend/src/types/（post.ts, comment.ts, scraping-state.ts）
- [ ] T020 [P] 實作 Post 資料存取層 frontend/src/services/storage/post-store.ts
- [ ] T021 [P] 實作 Comment 資料存取層 frontend/src/services/storage/comments-store.ts
- [ ] T022 [P] 實作 ScrapingState 資料存取層 frontend/src/services/storage/state-store.ts
- [ ] T023 [P] 實作配額管理模組 frontend/src/services/storage/quota-manager.ts
- [ ] T024 [P] 撰寫儲存層單元測試 frontend/tests/unit/storage.test.ts

### 核心服務

- [ ] T025 實作 URL 解析模組 frontend/src/services/api/url-parser.ts
- [ ] T026 實作後端 API 客戶端 frontend/src/services/api/backend-client.ts
- [ ] T027 實作時間格式化工具 frontend/src/services/utils/time-formatter.ts
- [ ] T028 [P] 實作錯誤處理工具 frontend/src/services/utils/error-handler.ts
- [ ] T029 [P] 撰寫工具模組單元測試 frontend/tests/unit/utils.test.ts

### 基礎 UI 元件

- [ ] T030 [P] 實作 Button 元件 frontend/src/components/common/Button.tsx
- [ ] T031 [P] 實作 Input 元件 frontend/src/components/common/Input.tsx
- [ ] T032 [P] 實作 Modal 元件 frontend/src/components/common/Modal.tsx
- [ ] T033 [P] 實作 Toast 通知系統 frontend/src/components/common/Toast.tsx
- [ ] T034 [P] 實作 ProgressBar 元件 frontend/src/components/common/ProgressBar.tsx
- [ ] T035 [P] 撰寫基礎元件單元測試 frontend/tests/unit/components/common.test.ts

**Checkpoint**: 基礎完成 - 使用者故事實作現在可以並行開始

---

## Phase 3: User Story 1 - 爬取單一貼文留言（Priority: P1）🎯 MVP

**目標**: 操作人員可以貼上網址，爬取 Instagram/Facebook 貼文的所有公開留言

**Independent Test**: 提供貼文網址，驗證系統能完整擷取並顯示所有留言

### 測試（TDD - 優先撰寫）

> **重要**: 這些測試必須先撰寫並確認失敗，然後才開始實作

- [ ] T036 [P] [US1] 撰寫 URL 解析單元測試 frontend/tests/unit/url-parser.test.ts
- [ ] T037 [P] [US1] 撰寫爬蟲服務契約測試（MSW）frontend/tests/mocks/graph-api.ts
- [ ] T038 [P] [US1] 撰寫爬取流程整合測試 frontend/tests/integration/scraping.spec.ts

### 核心實作

- [ ] T039 [P] [US1] 實作爬蟲服務核心邏輯 frontend/src/services/api/scraper-service.ts
- [ ] T040 [US1] 實作 Instagram 資料正規化 frontend/src/services/api/normalizers/instagram.ts（依賴 T039）
- [ ] T041 [US1] 實作 Facebook 資料正規化 frontend/src/services/api/normalizers/facebook.ts（依賴 T039）
- [ ] T042 [P] [US1] 實作自動續傳邏輯 frontend/src/services/api/resume-manager.ts
- [ ] T043 [P] [US1] 建立 useScraper Hook frontend/src/hooks/useScraper.ts

### UI 實作

- [ ] T044 [P] [US1] 實作 UrlInput 元件（網址輸入和驗證）frontend/src/components/scraper/UrlInput.tsx
- [ ] T045 [P] [US1] 實作 ScrapingProgress 元件（進度指示器）frontend/src/components/scraper/ScrapingProgress.tsx
- [ ] T046 [US1] 實作 CommentsTable 基礎版（僅顯示）frontend/src/components/table/CommentsTable.tsx（依賴 T039）
- [ ] T047 [US1] 實作 Home 頁面整合所有元件 frontend/src/pages/Home.tsx（依賴 T044-T046）

### 錯誤處理

- [ ] T048 [P] [US1] 實作網址格式驗證和錯誤訊息 frontend/src/services/api/url-validator.ts
- [ ] T049 [P] [US1] 實作網路錯誤處理和重試邏輯 frontend/src/services/api/retry-handler.ts
- [ ] T050 [P] [US1] 實作 API 錯誤訊息映射（繁中）frontend/src/services/utils/error-messages.ts

### 整合與驗證

- [ ] T051 [US1] 整合所有爬取功能到 Home 頁面（依賴 T044-T050）
- [ ] T052 [US1] 執行 E2E 測試驗證完整爬取流程
- [ ] T053 [US1] 效能測試：驗證首筆留言 <5 秒顯示

**Checkpoint**: 此時 User Story 1 應完全可用並可獨立測試。MVP 達成！

---

## Phase 4: User Story 2 - 線上編輯留言資料（Priority: P2）

**目標**: 使用者可以編輯表格、刪除留言、新增自訂欄位、搜尋篩選

**Independent Test**: 對已爬取的留言進行編輯，確認即時反映並持久化

### 測試（TDD）

- [ ] T054 [P] [US2] 撰寫表格編輯單元測試 frontend/tests/unit/table-editing.test.ts
- [ ] T055 [P] [US2] 撰寫復原功能單元測試 frontend/tests/unit/undo-manager.test.ts
- [ ] T056 [P] [US2] 撰寫編輯流程整合測試 frontend/tests/integration/editing.spec.ts

### 編輯功能實作

- [ ] T057 [P] [US2] 升級 CommentsTable 支援儲存格編輯 frontend/src/components/table/CommentsTable.tsx
- [ ] T058 [P] [US2] 實作 TableToolbar 元件（刪除、搜尋、篩選按鈕）frontend/src/components/table/TableToolbar.tsx
- [ ] T059 [P] [US2] 實作 SearchFilter 元件 frontend/src/components/table/SearchFilter.tsx
- [ ] T060 [US2] 實作刪除留言功能（含確認對話框）frontend/src/components/table/DeleteConfirm.tsx
- [ ] T061 [P] [US2] 建立 useComments Hook（CRUD 操作）frontend/src/hooks/useComments.ts

### 自訂欄位功能

- [ ] T062 [P] [US2] 實作 CustomFieldManager 元件（新增/刪除欄位）frontend/src/components/table/CustomFieldManager.tsx
- [ ] T063 [US2] 實作自訂欄位儲存邏輯 frontend/src/services/storage/custom-field-store.ts
- [ ] T064 [US2] 整合自訂欄位到 CommentsTable（動態欄位）

### 復原功能

- [ ] T065 [P] [US2] 實作 UndoManager（操作歷史管理）frontend/src/services/utils/undo-manager.ts
- [ ] T066 [US2] 實作復原/重做 UI 按鈕 frontend/src/components/table/UndoRedoButtons.tsx
- [ ] T067 [US2] 整合復原功能到編輯操作

### 整合與驗證

- [ ] T068 [US2] 建立 Editor 頁面整合所有編輯功能 frontend/src/pages/Editor.tsx
- [ ] T069 [US2] 執行 E2E 測試驗證編輯流程
- [ ] T070 [US2] 效能測試：驗證編輯回應 <100ms

**Checkpoint**: User Story 1 和 2 現在都獨立可用

---

## Phase 5: User Story 3 - 匯出為 Excel 檔案（Priority: P3）

**目標**: 使用者可以將留言資料匯出為 Excel 檔案（含自訂欄位，繁體中文無亂碼）

**Independent Test**: 點擊匯出按鈕，下載 .xlsx 檔案，在 Excel 中正常開啟

### 測試（TDD）

- [ ] T071 [P] [US3] 撰寫 Excel 匯出單元測試 frontend/tests/unit/excel-exporter.test.ts
- [ ] T072 [P] [US3] 撰寫匯出流程整合測試 frontend/tests/integration/export.spec.ts

### 匯出功能實作

- [ ] T073 [P] [US3] 實作 Excel 匯出核心邏輯（SheetJS）frontend/src/services/export/excel-exporter.ts
- [ ] T074 [P] [US3] 實作資料轉換（Comment → Excel 格式）frontend/src/services/export/data-transformer.ts
- [ ] T075 [P] [US3] 實作檔案命名邏輯（留言資料_日期時間.xlsx）frontend/src/services/export/file-namer.ts

### UI 實作

- [ ] T076 [P] [US3] 實作 ExportButton 元件 frontend/src/components/export/ExportButton.tsx
- [ ] T077 [P] [US3] 實作匯出選項對話框（全部 vs 篩選後）frontend/src/components/export/ExportOptionsDialog.tsx
- [ ] T078 [P] [US3] 實作匯出進度指示器 frontend/src/components/export/ExportProgress.tsx

### 整合與驗證

- [ ] T079 [US3] 整合匯出功能到 Editor 頁面
- [ ] T080 [US3] 測試繁體中文匯出無亂碼（多種 Excel 軟體）
- [ ] T081 [US3] 效能測試：1000 則留言匯出 <5 秒

**Checkpoint**: User Stories 1, 2, 3 全部獨立可用

---

## Phase 6: User Story 4 - 批次處理多個貼文（Priority: P4）

**目標**: 使用者可以一次輸入多個貼文網址進行批次爬取

**Independent Test**: 貼上多個網址，系統依序或並行爬取，整合顯示在同一表格

### 測試（TDD）

- [ ] T082 [P] [US4] 撰寫批次處理單元測試 frontend/tests/unit/batch-processor.test.ts
- [ ] T083 [P] [US4] 撰寫批次流程整合測試 frontend/tests/integration/batch.spec.ts

### 批次處理實作

- [ ] T084 [P] [US4] 實作批次處理器（排隊和並行控制）frontend/src/services/api/batch-processor.ts
- [ ] T085 [P] [US4] 實作檔案讀取器（.txt/.csv 上傳）frontend/src/services/utils/file-reader.ts
- [ ] T086 [P] [US4] 建立 useBatchScraper Hook frontend/src/hooks/useBatchScraper.ts

### UI 實作

- [ ] T087 [P] [US4] 實作 BatchMode 元件（多網址輸入）frontend/src/components/scraper/BatchMode.tsx
- [ ] T088 [P] [US4] 實作批次進度顯示（1/5 進行中）frontend/src/components/scraper/BatchProgress.tsx
- [ ] T089 [P] [US4] 實作檔案上傳按鈕和處理 frontend/src/components/scraper/FileUploader.tsx
- [ ] T090 [P] [US4] 實作取消批次作業按鈕 frontend/src/components/scraper/CancelBatchButton.tsx

### 整合與驗證

- [ ] T091 [US4] 整合批次模式到 Home 頁面（模式切換）
- [ ] T092 [US4] 測試批次錯誤處理（部分失敗場景）
- [ ] T093 [US4] 效能測試：10 個貼文 <5 分鐘

**Checkpoint**: 所有使用者故事（P1-P4）現在都獨立可用

---

## Phase 7: Polish & 跨功能優化

**目的**: 品質提升和跨故事的改進

### 憲章合規驗證

- [ ] T094 [P] 驗證程式碼覆蓋率 ≥80%（關鍵路徑 100%）
- [ ] T095 [P] 執行 ESLint 確保零警告
- [ ] T096 [P] 驗證 WCAG 2.1 AA 無障礙合規（axe-core）
- [ ] T097 [P] 執行 Lighthouse CI 驗證效能目標
- [ ] T098 [P] 執行安全掃描（npm audit）
- [ ] T099 程式碼審查：使用 comprehensive.md 檢查清單

### 配額與儲存管理

- [ ] T100 [P] 實作 QuotaWarning 橫幅元件 frontend/src/components/storage/QuotaWarning.tsx
- [ ] T101 [P] 實作 StorageCleanup 清理工具 UI frontend/src/components/storage/StorageCleanup.tsx
- [ ] T102 整合配額監控到應用程式生命週期

### 錯誤處理完善

- [ ] T103 [P] 實作全局錯誤邊界 frontend/src/components/ErrorBoundary.tsx
- [ ] T104 [P] 實作後端服務異常檢測和提示 frontend/src/services/api/health-checker.ts
- [ ] T105 測試所有錯誤場景（15+ 種）

### 無障礙與 UX 優化

- [ ] T106 [P] 實作鍵盤快捷鍵（Ctrl+Z 復原、Ctrl+F 搜尋）frontend/src/hooks/useKeyboardShortcuts.ts
- [ ] T107 [P] 新增 ARIA 標籤到所有互動元件
- [ ] T108 [P] 實作載入骨架屏（Skeleton screens）
- [ ] T109 測試螢幕閱讀器支援（NVDA/JAWS）

### 文件與部署

- [ ] T110 [P] 撰寫 API 文件 docs/api-documentation.md（繁中）
- [ ] T111 [P] 撰寫部署指南 docs/deployment-guide.md（繁中）
- [ ] T112 [P] 建立使用者手冊（繁中）docs/user-manual.md
- [ ] T113 [P] 更新 README.md 包含完整設置說明
- [ ] T114 設定 Vercel 生產環境部署
- [ ] T115 設定 Sentry 錯誤追蹤
- [ ] T116 執行 quickstart.md 驗證流程

---

## 依賴關係與執行順序

### 階段依賴

- **Setup (Phase 1)**: 無依賴 - 可立即開始
- **Foundational (Phase 2)**: 依賴 Setup 完成 - **阻擋所有使用者故事**
- **User Stories (Phase 3-6)**: 全部依賴 Foundational 完成
  - US1, US2, US3, US4 可並行開發（若有多位開發者）
  - 或按優先順序依序實作（P1 → P2 → P3 → P4）
- **Polish (Phase 7)**: 依賴所有欲實作的使用者故事完成

### 使用者故事依賴

- **User Story 1 (P1)**: Foundational 完成後即可開始 - 無其他故事依賴
- **User Story 2 (P2)**: 依賴 US1 的 CommentsTable 基礎版 - 可部分並行
- **User Story 3 (P3)**: 依賴 US2 的編輯功能 - 需要完整資料結構
- **User Story 4 (P4)**: 依賴 US1 的爬蟲邏輯 - 可獨立於 US2/US3

### 故事內任務依賴

**User Story 1 內部**:
- 測試 (T036-T038) → 必須先完成並失敗
- 核心實作 (T039-T043) → 可部分並行（標記 [P] 的）
- UI 實作 (T044-T047) → T047 依賴其他
- 錯誤處理 (T048-T050) → 可並行
- 整合 (T051-T053) → 最後執行

---

## 並行執行範例

### Setup 階段並行

```bash
# 可同時執行的任務（全部標記 [P]）
並行執行：T001, T002, T003, T004, T005, T006, T007, T008, T009, T010
```

### Foundational 階段並行

```bash
# 後端模組（可並行）
並行組 1：T011, T012, T013, T017

# IndexedDB 類型和存取層（可並行）
並行組 2：T019, T020, T021, T022, T023, T024

# 基礎元件（可並行）
並行組 3：T030, T031, T032, T033, T034, T035

# 依序：組 1 完成 → T014, T015, T016（依賴 T011-T013）
```

### User Story 1 並行

```bash
# 測試（必須先完成）
並行執行：T036, T037, T038

# 核心邏輯（可並行）
並行執行：T039, T042, T043

# 資料正規化（依賴 T039）
依序執行：T039 完成 → 並行執行 T040, T041

# UI 元件（可並行）
並行執行：T044, T045

# 錯誤處理（可並行）
並行執行：T048, T049, T050
```

---

## 實作策略

### MVP 優先（User Story 1 Only）

**最快路徑達成 MVP**：

1. 完成 Phase 1: Setup（T001-T010）- 0.5 天
2. 完成 Phase 2: Foundational（T011-T035）- 2 天
3. 完成 Phase 3: User Story 1（T036-T053）- 3 天
4. **停止並驗證**: 測試 US1 獨立運作
5. 部署/展示 MVP

**MVP 總時程**: 5.5-6.5 天

### 漸進式交付

每完成一個故事就測試和部署：

1. Setup + Foundational → 基礎就緒
2. 新增 US1 → 測試 → 部署/展示（MVP！）
3. 新增 US2 → 測試 → 部署/展示
4. 新增 US3 → 測試 → 部署/展示
5. 新增 US4 → 測試 → 部署/展示
6. Polish → 最終優化

### 並行團隊策略

若有多位開發者：

1. 團隊一起完成 Setup + Foundational
2. Foundational 完成後分工：
   - **開發者 A**: User Story 1（爬取功能）
   - **開發者 B**: User Story 2（編輯功能）
   - **開發者 C**: 後端優化 + 監控設置
3. 故事完成後獨立整合和測試

---

## 任務統計

| 階段 | 任務數 | 預估時間 | 可並行 |
|------|-------|---------|--------|
| Phase 1: Setup | 10 | 0.5 天 | 100% |
| Phase 2: Foundation | 25 | 2 天 | ~60% |
| Phase 3: US1 (MVP) | 18 | 3 天 | ~50% |
| Phase 4: US2 | 17 | 3 天 | ~60% |
| Phase 5: US3 | 11 | 2 天 | ~70% |
| Phase 6: US4 | 12 | 2 天 | ~70% |
| Phase 7: Polish | 23 | 2 天 | ~80% |
| **總計** | **116 任務** | **14.5 天** | **~65%** |

**並行機會**:
- Setup: 10 個任務可同時執行
- Foundation: 15 個任務可並行（在依賴允許範圍內）
- 每個 US: 測試和獨立模組可並行
- Polish: 大部分任務可並行

---

## 註記

- **[P]** 標記的任務 = 不同檔案，無依賴，可並行
- **[Story]** 標籤映射任務到使用者故事，便於追蹤
- 每個使用者故事都可獨立完成和測試
- 測試必須先撰寫並失敗，再開始實作（TDD）
- 建議在每個 Checkpoint 停下來驗證故事獨立運作
- Commit 頻率：每完成 1-3 個相關任務即 commit

---

## 下一步

1. ✅ **任務清單已完成**
2. ⏭️ **選擇實作策略**：
   - MVP 優先（推薦）：專注 Phase 1-3
   - 完整開發：依序執行 Phase 1-7
   - 並行開發：多人分工
3. ⏭️ **開始實作**：從 T001 開始
4. ⏭️ **持續追蹤**：勾選已完成任務，監控進度

---

**任務清單完成日期**: 2025-11-19  
**總任務數**: 116  
**預估總時程**: 14.5 天（單人）或 7-10 天（雙人並行）  
**MVP 時程**: 5.5-6.5 天

🎯 **準備好開始編碼了！建議從 T001 開始，逐步完成 MVP！**

