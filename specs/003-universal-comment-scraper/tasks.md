# Tasks: 通用留言擷取工具

**Input**: `specs/003-universal-comment-scraper/`  
**Prerequisites**: plan.md ✅, spec.md ✅, data-model.md ✅, research.md ✅, contracts/ ✅  
**Generated**: 2025-12-02  
**Total Tasks**: 68 任務  

## Format: `[ID] [P?] [Story] Description`

- **[P]**: 可平行執行（不同檔案、無依賴）
- **[Story]**: 所屬用戶故事（US1, US2, US3, US4, US5）
- 路徑基於 `universal-scraper/frontend/`

---

## Phase 1: Setup（專案初始化）

**Purpose**: 建立專案基礎架構

- [ ] T001 建立專案資料夾結構 `universal-scraper/frontend/` 依據 plan.md
- [ ] T002 初始化 Vite + React + TypeScript 專案 `pnpm create vite frontend --template react-ts`
- [ ] T003 [P] 安裝核心依賴 `dexie ag-grid-react xlsx axios crypto-js`
- [ ] T004 [P] 安裝開發依賴 `tailwindcss vitest @testing-library/react`
- [ ] T005 [P] 配置 Tailwind CSS 在 `frontend/tailwind.config.js`
- [ ] T006 [P] 配置 TypeScript 嚴格模式在 `frontend/tsconfig.json`
- [ ] T007 [P] 建立 ESLint + Prettier 配置檔案
- [ ] T008 建立環境變數配置 `frontend/.env.example` 和 `.env.local`

**Checkpoint**: 專案結構就緒，可執行 `pnpm dev`

---

## Phase 2: Foundational（基礎建設）

**Purpose**: 核心基礎設施，所有用戶故事的前置條件

**⚠️ 關鍵**: 此階段完成前，不能開始任何用戶故事開發

### 資料庫架構

- [ ] T009 實作 IndexedDB 配置在 `frontend/src/services/storage/db.ts`（使用 Dexie.js）
- [ ] T010 [P] 定義 PlatformConfig 類型在 `frontend/src/platforms/base/types.ts`
- [ ] T011 [P] 定義 UnifiedComment 類型在 `frontend/src/platforms/base/types.ts`
- [ ] T012 [P] 定義 ScrapeTask 類型在 `frontend/src/platforms/base/types.ts`
- [ ] T013 [P] 定義 EncryptedCredential 類型在 `frontend/src/platforms/base/types.ts`

### 平台適配器基礎

- [ ] T014 實作 PlatformAdapter 抽象基類在 `frontend/src/platforms/base/PlatformAdapter.ts`
- [ ] T015 實作平台註冊表在 `frontend/src/platforms/registry.ts`
- [ ] T016 [P] 實作 URL 識別工具函數在 `frontend/src/platforms/base/url-utils.ts`

### 認證框架

- [ ] T017 實作 Token 加密/解密工具在 `frontend/src/services/auth/crypto-utils.ts`
- [ ] T018 [P] 實作憑證儲存服務在 `frontend/src/services/auth/credential-store.ts`

### UI 基礎

- [ ] T019 [P] 建立共用 UI 組件資料夾結構 `frontend/src/components/`
- [ ] T020 [P] 實作基礎 Layout 組件在 `frontend/src/components/Layout.tsx`
- [ ] T021 [P] 實作錯誤邊界組件在 `frontend/src/components/ErrorBoundary.tsx`
- [ ] T022 [P] 配置全域 CSS 變數和主題在 `frontend/src/index.css`

**Checkpoint**: 基礎設施就緒，可開始用戶故事開發

---

## Phase 3: User Story 1 - 智能平台識別與擷取設定 (Priority: P1) 🎯 MVP

**Goal**: 使用者輸入網址，系統自動識別平台類型，引導完成認證設定

**Independent Test**: 輸入 Facebook/Instagram/Medium 網址，系統正確識別並顯示對應認證需求

### 實作 User Story 1

- [ ] T023 [US1] 實作 Facebook URL 解析器在 `frontend/src/platforms/facebook/url-parser.ts`
- [ ] T024 [P] [US1] 實作 Instagram URL 解析器在 `frontend/src/platforms/instagram/url-parser.ts`
- [ ] T025 [US1] 實作 FacebookAdapter 類別在 `frontend/src/platforms/facebook/FacebookAdapter.ts`
- [ ] T026 [P] [US1] 實作 InstagramAdapter 類別在 `frontend/src/platforms/instagram/InstagramAdapter.ts`
- [ ] T027 [US1] 實作平台識別邏輯在 `frontend/src/services/platform-detector.ts`
- [ ] T028 [US1] 實作 Token 驗證服務在 `frontend/src/services/auth/token-validator.ts`
- [ ] T029 [US1] 實作首頁 URL 輸入組件在 `frontend/src/pages/HomePage.tsx`
- [ ] T030 [US1] 實作平台識別結果顯示組件在 `frontend/src/components/PlatformDetectionResult.tsx`
- [ ] T031 [US1] 實作認證選擇彈窗組件在 `frontend/src/components/AuthModal.tsx`
- [ ] T032 [US1] 實作 Token 輸入表單組件在 `frontend/src/components/TokenInputForm.tsx`
- [ ] T033 [US1] 實作帳密輸入表單組件在 `frontend/src/components/LoginForm.tsx`
- [ ] T034 [US1] 整合 HomePage 與所有認證組件
- [ ] T035 [US1] 加入繁體中文錯誤訊息和提示文字

**Checkpoint**: US1 完成 - 使用者可輸入網址、識別平台、設定認證

---

## Phase 4: User Story 2 - 多平台留言擷取執行 (Priority: P2)

**Goal**: 認證完成後，系統使用對應方式擷取留言，顯示即時進度

**Independent Test**: 提供 Facebook Token 和貼文網址，成功擷取所有留言

### 實作 User Story 2

- [ ] T036 [US2] 實作 Facebook API 客戶端在 `frontend/src/platforms/facebook/api-client.ts`
- [ ] T037 [P] [US2] 實作 Instagram API 客戶端在 `frontend/src/platforms/instagram/api-client.ts`
- [ ] T038 [US2] 實作分頁處理邏輯在 `frontend/src/services/scraper/pagination-handler.ts`
- [ ] T039 [US2] 實作擷取引擎在 `frontend/src/services/scraper/scrape-engine.ts`
- [ ] T040 [US2] 實作進度追蹤器在 `frontend/src/services/scraper/progress-tracker.ts`
- [ ] T041 [US2] 實作結果聚合器在 `frontend/src/services/scraper/result-aggregator.ts`
- [ ] T042 [US2] 實作留言正規化工具在 `frontend/src/platforms/base/comment-normalizer.ts`
- [ ] T043 [US2] 實作擷取進度顯示組件在 `frontend/src/components/ScrapeProgress.tsx`
- [ ] T044 [US2] 實作擷取頁面在 `frontend/src/pages/ScrapePage.tsx`
- [ ] T045 [US2] 加入錯誤處理（速率限制、網路錯誤、權限不足）
- [ ] T046 [US2] 實作批次擷取模式（多個網址）支援

**Checkpoint**: US2 完成 - 使用者可執行擷取，看到即時進度

---

## Phase 5: User Story 3 - 留言資料顯示與即時查看 (Priority: P3)

**Goal**: 擷取完成後，以表格顯示留言，支援搜尋、篩選、排序

**Independent Test**: 擷取結果以表格顯示，可搜尋關鍵字、按時間排序

### 實作 User Story 3

- [ ] T047 [US3] 配置 AG Grid 在 `frontend/src/components/CommentGrid.tsx`
- [ ] T048 [US3] 實作留言欄位定義在 `frontend/src/components/grid/columnDefs.ts`
- [ ] T049 [US3] 實作搜尋篩選功能在 `frontend/src/components/SearchFilter.tsx`
- [ ] T050 [US3] 實作排序功能（時間、按讚數）
- [ ] T051 [US3] 實作留言者篩選功能（點擊留言者姓名）
- [ ] T052 [US3] 實作虛擬滾動（大量留言效能優化）
- [ ] T053 [US3] 實作結果頁面在 `frontend/src/pages/ResultsPage.tsx`
- [ ] T054 [US3] 加入統計摘要顯示（總留言數、唯一留言者數等）

**Checkpoint**: US3 完成 - 使用者可瀏覽、搜尋、篩選留言資料

---

## Phase 6: User Story 4 - 資料匯出與格式化 (Priority: P4)

**Goal**: 使用者可匯出 Excel，繁體中文無亂碼

**Independent Test**: 點擊匯出，下載 Excel 檔案，在 Excel 開啟顯示正確

### 實作 User Story 4

- [ ] T055 [US4] 實作 Excel 匯出服務在 `frontend/src/services/export/excel-exporter.ts`（使用 SheetJS）
- [ ] T056 [US4] 實作資料格式化（時間格式、欄位名稱統一）
- [ ] T057 [US4] 實作匯出選項彈窗在 `frontend/src/components/ExportModal.tsx`
- [ ] T058 [US4] 整合匯出按鈕到結果頁面
- [ ] T059 [US4] 支援匯出篩選後資料選項

**Checkpoint**: US4 完成 - 使用者可匯出完整或篩選後的 Excel 檔案

---

## Phase 7: User Story 5 - Chrome擴充套件整合 (Priority: P5) 【V2階段】

**Goal**: 安裝擴充套件後，瀏覽支援平台時可直接擷取

**Independent Test**: 在 Facebook 頁面點擊擴充圖示，彈窗顯示擷取選項

### 實作 User Story 5

- [ ] T060 [US5] 建立 Chrome Extension 專案結構 `universal-scraper/extension/`
- [ ] T061 [US5] 建立 manifest.json（Manifest V3）
- [ ] T062 [US5] 實作 Background Service Worker 在 `extension/background.js`
- [ ] T063 [US5] 實作 Content Script 在 `extension/content.js`
- [ ] T064 [US5] 實作 Popup UI 在 `extension/popup.html` 和 `extension/popup.js`
- [ ] T065 [US5] 整合平台識別邏輯到 Content Script
- [ ] T066 [US5] 實作擴充圖示狀態切換（支援/不支援平台）

**Checkpoint**: US5 完成 - Chrome 擴充套件可使用

---

## Phase 8: Polish & Cross-Cutting Concerns

**Purpose**: 品質驗證和跨功能優化

### 憲章合規驗證

- [ ] T067 [P] 驗證所有 UI 文字為繁體中文（zh-TW）
- [ ] T068 [P] 驗證錯誤訊息提供具體指引

---

## Dependencies & Execution Order

### 階段依賴

```
Phase 1 (Setup) → Phase 2 (Foundational) → [US1, US2, US3, US4] → Phase 8 (Polish)
                                              ↓
                                           Phase 7 (US5 - V2階段)
```

### 用戶故事依賴

| 故事 | 依賴 | 說明 |
|------|------|------|
| US1 | Phase 2 | 平台識別與認證（MVP核心）|
| US2 | US1 | 需要認證完成才能擷取 |
| US3 | US2 | 需要有資料才能顯示 |
| US4 | US3 | 需要有資料才能匯出 |
| US5 | US1-US4 | V2階段，需網頁版穩定 |

### 平行執行機會

**Phase 1**:
```bash
# 同時執行
T003: 安裝核心依賴
T004: 安裝開發依賴
T005: 配置 Tailwind
T006: 配置 TypeScript
T007: ESLint + Prettier
```

**Phase 2**:
```bash
# 同時執行
T010-T013: 所有類型定義
T019-T022: 所有 UI 基礎組件
```

**Phase 3 (US1)**:
```bash
# 同時執行
T023: Facebook URL 解析器
T024: Instagram URL 解析器
# 完成後同時執行
T025: FacebookAdapter
T026: InstagramAdapter
```

---

## Implementation Strategy

### MVP First（僅 US1 + US2 + US3 + US4）

1. 完成 Phase 1: Setup
2. 完成 Phase 2: Foundational
3. 完成 Phase 3: US1（平台識別 + 認證）
4. **驗證**: 測試 US1 獨立運作
5. 完成 Phase 4: US2（擷取執行）
6. 完成 Phase 5: US3（資料顯示）
7. 完成 Phase 6: US4（Excel 匯出）
8. **MVP 完成** 🎉
9. 部署測試版

### V2 階段

1. 完成 Phase 7: US5（Chrome 擴充套件）
2. 完成 Phase 8: Polish
3. 發布正式版

### 時程估計

| 階段 | 任務數 | 預估時間 |
|------|--------|----------|
| Phase 1-2 | 22 | 1 週 |
| Phase 3 (US1) | 13 | 1 週 |
| Phase 4 (US2) | 11 | 1 週 |
| Phase 5-6 (US3+US4) | 13 | 1 週 |
| **MVP 總計** | **59** | **4 週** |
| Phase 7 (US5) | 7 | 2 週 |
| Phase 8 (Polish) | 2 | 0.5 週 |
| **完整版總計** | **68** | **6.5 週** |

---

## Notes

- 所有檔案路徑以 `universal-scraper/frontend/` 為基準
- [P] 任務可平行執行
- [US?] 標記對應的用戶故事
- 每完成邏輯群組後提交 commit
- MVP 完成時可先部署驗證
- US5（Chrome 擴充）安排在 V2 階段

---

**Generated**: 2025-12-02  
**Total Tasks**: 68  
**MVP Tasks**: 59  
**Estimated MVP Time**: 4 週
