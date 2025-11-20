# 任務清單：通用留言擷取工具

**Input**: specs/003-universal-comment-scraper/  
**MVP範圍**: Facebook + Instagram API擷取  
**完整願景**: 8+平台通用擷取工具 + Chrome擴充套件

**組織方式**: 按功能模組和使用者故事分組

---

## Phase 1: Setup（專案初始化）

**目的**: 建立專案基礎結構和開發環境

- [ ] T001 [P] 建立專案根目錄結構（universal-scraper/frontend/, api/, docs/）
- [ ] T002 [P] 初始化前端React + TypeScript + Vite專案在frontend/
- [ ] T003 [P] 安裝核心依賴（React, Dexie, AG Grid, crypto-js, axios）
- [ ] T004 [P] 設定ESLint和Prettier配置
- [ ] T005 [P] 設定Tailwind CSS
- [ ] T006 [P] 建立TypeScript類型定義結構frontend/src/types/
- [ ] T007 [P] 設定環境變數範本.env.example
- [ ] T008 [P] 建立vercel.json部署設定
- [ ] T009 [P] 設定Git hooks（Husky）
- [ ] T010 [P] 建立README.md（繁體中文，專案說明）

---

## Phase 2: Foundation - 平台適配器核心架構

**目的**: 建立模組化的平台適配器基礎設施

### 基礎架構

- [ ] T011 設計並實作PlatformAdapter抽象基類frontend/src/platforms/base/PlatformAdapter.ts
- [ ] T012 [P] 定義平台適配器類型frontend/src/platforms/base/types.ts
- [ ] T013 [P] 實作平台註冊表（Registry Pattern）frontend/src/platforms/registry.ts
- [ ] T014 [P] 實作平台偵測器（URL → 平台識別）frontend/src/services/platform-detector.ts
- [ ] T015 [P] 撰寫平台架構單元測試frontend/tests/unit/platform-base.test.ts

### IndexedDB資料層

- [ ] T016 設定Dexie.js資料庫Schema frontend/src/services/storage/db.ts
- [ ] T017 [P] 定義所有TypeScript介面frontend/src/types/（comment, task, credential, platform）
- [ ] T018 [P] 實作Comment資料存取層frontend/src/services/storage/comments-store.ts
- [ ] T019 [P] 實作Task資料存取層frontend/src/services/storage/tasks-store.ts
- [ ] T020 [P] 實作配額管理器frontend/src/services/storage/quota-manager.ts
- [ ] T021 [P] 撰寫儲存層單元測試frontend/tests/unit/storage.test.ts

### 核心服務

- [ ] T022 [P] 實作URL解析工具frontend/src/services/utils/url-parser.ts
- [ ] T023 [P] 實作時間格式化工具frontend/src/services/utils/time-formatter.ts
- [ ] T024 [P] 實作資料驗證器frontend/src/services/utils/validator.ts
- [ ] T025 [P] 實作錯誤處理工具frontend/src/services/utils/error-handler.ts
- [ ] T026 [P] 撰寫工具模組測試frontend/tests/unit/utils.test.ts

### 基礎UI元件

- [ ] T027 [P] 實作Button元件frontend/src/components/common/Button.tsx
- [ ] T028 [P] 實作Input元件frontend/src/components/common/Input.tsx
- [ ] T029 [P] 實作Modal元件frontend/src/components/common/Modal.tsx
- [ ] T030 [P] 實作Toast通知系統frontend/src/components/common/Toast.tsx
- [ ] T031 [P] 實作ProgressBar元件frontend/src/components/common/ProgressBar.tsx
- [ ] T032 [P] 撰寫基礎元件測試frontend/tests/unit/components/common.test.ts

**Checkpoint**: 基礎架構完成，可以開始實作具體平台適配器

---

## Phase 3: 認證系統（多模式支援）

**目的**: 實作Token和憑證管理，支援API和帳密模式

### 認證核心

- [ ] T033 [P] 實作Token管理器（加密儲存AES-256）frontend/src/services/auth/token-manager.ts
- [ ] T034 [P] 實作憑證加密模組（crypto-js）frontend/src/services/auth/crypto-utils.ts
- [ ] T035 [P] 實作憑證儲存層（IndexedDB加密）frontend/src/services/auth/credential-store.ts
- [ ] T036 實作認證驗證器（多平台）frontend/src/services/auth/auth-validator.ts
- [ ] T037 [P] 實作認證狀態管理Hook frontend/src/hooks/useAuth.ts
- [ ] T038 [P] 撰寫認證系統測試frontend/tests/unit/auth.test.ts

### 後端Token保護

- [ ] T039 [P] 實作Token管理模組（後端）api/_lib/token-manager.ts
- [ ] T040 [P] 實作速率限制（Token Bucket）api/_lib/rate-limiter.ts
- [ ] T041 [P] 實作錯誤映射（API錯誤→繁中）api/_lib/error-mapper.ts
- [ ] T042 [P] 撰寫後端模組測試api/_tests/lib.test.ts

**Checkpoint**: 認證系統完成，支援Token加密儲存和驗證

---

## Phase 4: Facebook適配器（完整實作）

**目的**: 實作Facebook平台的完整擷取功能

### 測試（TDD）

- [ ] T043 [P] 撰寫Facebook適配器契約測試frontend/tests/unit/facebook-adapter.test.ts
- [ ] T044 [P] 撰寫Facebook API客戶端測試（MSW）frontend/tests/mocks/facebook-api.ts

### 核心實作

- [ ] T045 實作FacebookAdapter類frontend/src/platforms/facebook/FacebookAdapter.ts
- [ ] T046 [P] 實作Facebook URL解析器frontend/src/platforms/facebook/url-parser.ts
- [ ] T047 [P] 實作Facebook資料正規化frontend/src/platforms/facebook/normalizer.ts
- [ ] T048 實作Facebook API客戶端（前端）frontend/src/platforms/facebook/api-client.ts
- [ ] T049 實作Facebook後端API代理api/facebook.ts（依賴T039-T041）
- [ ] T050 [P] 實作Facebook貼文資訊取得frontend/src/platforms/facebook/post-fetcher.ts
- [ ] T051 [P] 實作Facebook分頁處理frontend/src/platforms/facebook/pagination-handler.ts

### 整合測試

- [ ] T052 Facebook端到端測試（真實API或Mock）frontend/tests/integration/facebook.spec.ts
- [ ] T053 Facebook錯誤處理測試

**Checkpoint**: Facebook完整可用，可擷取單一貼文和粉專批次留言

---

## Phase 5: Instagram適配器（完整實作）

**目的**: 實作Instagram平台的完整擷取功能

### 測試（TDD）

- [ ] T054 [P] 撰寫Instagram適配器契約測試frontend/tests/unit/instagram-adapter.test.ts
- [ ] T055 [P] 撰寫Instagram API客戶端測試（MSW）frontend/tests/mocks/instagram-api.ts

### 核心實作

- [ ] T056 實作InstagramAdapter類frontend/src/platforms/instagram/InstagramAdapter.ts
- [ ] T057 [P] 實作Instagram URL解析器frontend/src/platforms/instagram/url-parser.ts
- [ ] T058 [P] 實作Instagram資料正規化frontend/src/platforms/instagram/normalizer.ts
- [ ] T059 實作Instagram API客戶端（前端）frontend/src/platforms/instagram/api-client.ts
- [ ] T060 實作Instagram後端API代理api/instagram.ts（依賴T039-T041）
- [ ] T061 [P] 實作Instagram帳號資訊取得frontend/src/platforms/instagram/account-fetcher.ts
- [ ] T062 [P] 實作Instagram分頁處理frontend/src/platforms/instagram/pagination-handler.ts

### 整合測試

- [ ] T063 Instagram端到端測試frontend/tests/integration/instagram.spec.ts
- [ ] T064 Instagram錯誤處理測試

**Checkpoint**: Instagram完整可用，可擷取貼文和帳號批次留言

---

## Phase 6: 擷取引擎（統一協調層）

**目的**: 實作跨平台的擷取引擎和進度管理

- [ ] T065 實作ScrapeEngine核心類frontend/src/services/scraper/scrape-engine.ts
- [ ] T066 [P] 實作進度追蹤器（事件發射）frontend/src/services/scraper/progress-tracker.ts
- [ ] T067 [P] 實作結果聚合器（跨平台資料整合）frontend/src/services/scraper/result-aggregator.ts
- [ ] T068 [P] 實作批次處理器（多URL）frontend/src/services/scraper/batch-processor.ts
- [ ] T069 [P] 實作錯誤重試邏輯frontend/src/services/scraper/retry-handler.ts
- [ ] T070 [P] 建立useScraper Hook frontend/src/hooks/useScraper.ts
- [ ] T071 [P] 撰寫擷取引擎測試frontend/tests/unit/scraper.test.ts

**Checkpoint**: 擷取引擎完成，支援多平台統一介面

---

## Phase 7: UI實作（使用者介面）

**目的**: 建立完整的使用者介面

### URL輸入與平台識別

- [ ] T072 [P] 實作URLInput元件（網址輸入）frontend/src/components/scraper/URLInput.tsx
- [ ] T073 [P] 實作PlatformBadge元件（平台標示）frontend/src/components/scraper/PlatformBadge.tsx
- [ ] T074 實作PlatformSelector元件（手動選擇平台）frontend/src/components/scraper/PlatformSelector.tsx

### 認證介面

- [ ] T075 [P] 實作TokenInput元件（Token輸入和驗證）frontend/src/components/auth/TokenInput.tsx
- [ ] T076 [P] 實作AuthModal元件（認證選擇對話框）frontend/src/components/auth/AuthModal.tsx
- [ ] T077 [P] 實作TokenManager UI元件（Token管理介面）frontend/src/components/auth/TokenManager.tsx

### 擷取介面

- [ ] T078 [P] 實作ScrapeProgress元件（進度條和狀態）frontend/src/components/scraper/ScrapeProgress.tsx
- [ ] T079 [P] 實作BatchModeToggle元件（批次模式切換）frontend/src/components/scraper/BatchModeToggle.tsx
- [ ] T080 實作ScrapeControls元件（開始、暫停、取消）frontend/src/components/scraper/ScrapeControls.tsx

### 結果顯示

- [ ] T081 實作CommentsTable元件（使用AG Grid）frontend/src/components/results/CommentsTable.tsx
- [ ] T082 [P] 實作CommentsFilter元件（搜尋篩選）frontend/src/components/results/CommentsFilter.tsx
- [ ] T083 [P] 實作CommentStats元件（統計卡片）frontend/src/components/results/CommentStats.tsx
- [ ] T084 [P] 實作ExportButton元件（Excel匯出）frontend/src/components/results/ExportButton.tsx
- [ ] T085 [P] 實作CopyButton元件（複製功能）frontend/src/components/results/CopyButton.tsx

### 頁面整合

- [ ] T086 實作Home頁面（整合所有元件）frontend/src/pages/Home.tsx
- [ ] T087 [P] 實作History頁面（擷取歷史）frontend/src/pages/History.tsx
- [ ] T088 [P] 實作Settings頁面（設定和Token管理）frontend/src/pages/Settings.tsx

**Checkpoint**: 完整UI可用，所有功能可視化操作

---

## Phase 8: 資料處理與匯出

**目的**: 實作資料轉換和匯出功能

- [ ] T089 [P] 實作Excel匯出邏輯（SheetJS）frontend/src/services/export/excel-exporter.ts
- [ ] T090 [P] 實作資料轉換器（UnifiedComment → Excel）frontend/src/services/export/data-transformer.ts
- [ ] T091 [P] 實作檔案命名邏輯frontend/src/services/export/file-namer.ts
- [ ] T092 [P] 實作複製到剪貼簿功能frontend/src/services/export/clipboard-handler.ts
- [ ] T093 [P] 測試Excel匯出（繁體中文、emoji）

**Checkpoint**: 資料可完整匯出，格式正確

---

## Phase 9: 整合與端到端測試

**目的**: 整合所有功能並進行完整測試

### 整合

- [ ] T094 整合Facebook適配器到主流程
- [ ] T095 整合Instagram適配器到主流程
- [ ] T096 整合認證系統到UI
- [ ] T097 整合擷取引擎到UI

### 端到端測試

- [ ] T098 [P] E2E測試：Facebook單一貼文擷取frontend/tests/e2e/facebook-post.spec.ts
- [ ] T099 [P] E2E測試：Facebook粉專批次擷取frontend/tests/e2e/facebook-page.spec.ts
- [ ] T100 [P] E2E測試：Instagram單一貼文擷取frontend/tests/e2e/instagram-post.spec.ts
- [ ] T101 [P] E2E測試：Instagram帳號批次擷取frontend/tests/e2e/instagram-account.spec.ts
- [ ] T102 [P] E2E測試：跨平台批次擷取（FB+IG）frontend/tests/e2e/multi-platform.spec.ts

### 效能測試

- [ ] T103 [P] 效能測試：1000則留言處理
- [ ] T104 [P] 效能測試：記憶體使用監控
- [ ] T105 [P] 效能測試：API速率限制處理

**Checkpoint**: 所有功能經過完整測試，品質保證

---

## Phase 10: Polish & 優化

**目的**: 品質提升和使用者體驗優化

### 憲章合規驗證

- [ ] T106 [P] 驗證程式碼覆蓋率≥80%
- [ ] T107 [P] ESLint零警告檢查
- [ ] T108 [P] WCAG 2.1 AA無障礙驗證
- [ ] T109 [P] Lighthouse CI效能檢查

### 錯誤處理完善

- [ ] T110 [P] 實作全局錯誤邊界frontend/src/components/ErrorBoundary.tsx
- [ ] T111 [P] 完善所有平台錯誤訊息（繁中）
- [ ] T112 測試所有錯誤場景（15+種）

### UX優化

- [ ] T113 [P] 實作鍵盤快捷鍵（Ctrl+Z, Ctrl+F, Ctrl+S）
- [ ] T114 [P] 實作載入骨架屏
- [ ] T115 [P] 實作首次使用引導（Onboarding）
- [ ] T116 [P] 優化動畫和過渡效果

### 文件與部署

- [ ] T117 [P] 撰寫使用者手冊（繁中）docs/user-guide.md
- [ ] T118 [P] 撰寫開發者文件docs/developer-guide.md
- [ ] T119 [P] 建立平台擴展指南docs/adding-platforms.md
- [ ] T120 [P] 更新README.md完整說明
- [ ] T121 設定Vercel生產環境部署
- [ ] T122 設定Sentry錯誤追蹤
- [ ] T123 設定Google Analytics（可選）
- [ ] T124 執行完整quickstart.md驗證

**Checkpoint**: MVP完成，可部署上線

---

## Phase 11: V2準備（未來擴展）

**目的**: 為V2平台擴展做準備（不在MVP範圍）

### Medium適配器（V2）

- [ ] T125 [P] 研究Medium API/爬蟲方式
- [ ] T126 [P] 實作MediumAdapter
- [ ] T127 測試Medium擷取

### 方格子適配器（V2）

- [ ] T128 [P] 研究Vocus網頁結構
- [ ] T129 [P] 實作VocusAdapter
- [ ] T130 測試方格子擷取

### 通用爬蟲模式（V2）

- [ ] T131 [P] 實作GenericAdapter（CSS Selector配置）
- [ ] T132 實作使用者自定義爬蟲規則UI

---

## Phase 12: Chrome擴充套件（V3）

**目的**: 開發Chrome擴充套件版本（不在MVP範圍）

- [ ] T133 建立Manifest V3配置
- [ ] T134 [P] 實作Background Service Worker
- [ ] T135 [P] 實作Content Scripts（頁面注入）
- [ ] T136 [P] 實作Popup介面
- [ ] T137 [P] 實作擴充套件與網頁版資料同步
- [ ] T138 提交Chrome Web Store

---

## 任務統計與時程

| 階段 | 任務數 | 預估時間 | 可並行 |
|------|-------|---------|--------|
| Phase 1: Setup | 10 | 0.5天 | 100% |
| Phase 2: Foundation | 22 | 2天 | ~70% |
| Phase 3: 認證系統 | 10 | 1天 | ~60% |
| Phase 4: Facebook | 11 | 1週 | ~50% |
| Phase 5: Instagram | 11 | 1週 | ~50% |
| Phase 6: 擷取引擎 | 7 | 2天 | ~70% |
| Phase 7: UI實作 | 17 | 1週 | ~60% |
| Phase 8: 資料處理 | 5 | 1天 | ~80% |
| Phase 9: 整合測試 | 12 | 2天 | ~60% |
| Phase 10: Polish | 19 | 3天 | ~70% |
| **MVP總計** | **124任務** | **4週** | **~65%** |
| Phase 11: V2平台 | 8 | +2週 | - |
| Phase 12: Chrome擴充 | 6 | +2週 | - |
| **完整總計** | **138任務** | **8週** | - |

---

## MVP路徑（優先）

**Week 1**: Setup + Foundation + 認證（T001-T042）  
**Week 2**: Facebook適配器完整實作（T043-T053）  
**Week 3**: Instagram適配器完整實作（T054-T064）  
**Week 4**: 擷取引擎 + UI + 測試 + 部署（T065-T124）  

**MVP交付**: FB + IG 留言擷取工具，網頁版

---

## 執行策略

### MVP優先（推薦）

```
專注前124個任務
4週完成核心功能
驗證產品價值
```

### 完整產品

```
執行全部138個任務
8週完成（包含V2平台 + Chrome擴充）
完整的多平台產品
```

---

**任務清單完成**: 2025-11-20  
**總任務數**: 124（MVP），138（完整）  
**預估時程**: 4週（MVP），8週（完整）  
**下一步**: 開始實作或繼續V2/V3規劃


