# 實作計劃：社群留言爬蟲工具

**Branch**: `001-social-comment-scraper` | **Date**: 2025-11-19 | **Spec**: [spec.md](./spec.md)  
**Input**: 功能規格書來自 `/specs/001-social-comment-scraper/spec.md`

## 摘要

本專案開發一個線上社群留言爬蟲工具，讓非技術背景的操作人員能輕鬆從 Instagram 和 Facebook 公開貼文擷取留言資料。系統採用前端為主的 Web 應用程式搭配輕量後端 API 代理層，提供直覺的使用介面、即時的線上編輯功能，以及一鍵 Excel 匯出。核心技術方案包括：使用官方 Graph API 確保合規性、IndexedDB 本地儲存提供隱私保護、Serverless Functions 保護 API Token 安全。系統支援自動續傳機制以提升資料可靠性，並實作配額管理以確保長期可用性。

**技術方案重點**：
- 前端：React + TypeScript SPA，使用 AG Grid 表格編輯，SheetJS Excel 匯出
- 後端：Vercel Serverless Functions 作為 API 代理，保護 Token 和管理速率限制
- 儲存：Dexie.js（IndexedDB wrapper）+ localStorage
- API：Instagram/Facebook Graph API（應用程式層級授權）

---

## 技術背景

**Language/Version**: 
- 前端：TypeScript 5.2+, React 18+
- 後端：Node.js 18+ (Vercel Serverless Functions)

**Primary Dependencies**:  
- 前端：React, Vite, AG Grid Community, SheetJS (xlsx), Dexie.js, date-fns, Tailwind CSS
- 後端：@vercel/node, axios, node-cache (速率限制)

**Storage**:  
- IndexedDB（透過 Dexie.js）：留言資料、爬取狀態、操作歷史
- localStorage：使用者偏好設定、UI 狀態
- 後端無持久化儲存（純代理層）

**Testing**:  
- 前端：Vitest（單元測試）, Playwright（整合測試）, Lighthouse CI（效能測試）
- 後端：Vitest（API 代理測試）, Supertest（端點測試）
- 契約測試：使用 Mock Service Worker (MSW) 模擬 Graph API

**Target Platform**:  
- Web 應用程式（瀏覽器端）
- 目標瀏覽器：Chrome 90+, Edge 90+, Firefox 88+, Safari 14+
- 部署：Vercel（前端 + Functions）

**Project Type**: Web application（前端 + 後端代理混合架構）

**Performance Goals**:  
- 頁面初次載入：<2 秒（3G 網路）
- 爬取首筆留言：<5 秒（100 則留言內的貼文）
- 表格編輯回應：<100ms
- Excel 匯出：1000 則留言 <5 秒
- 前端 bundle：<300KB gzipped

**Constraints**:  
- API 回應時間：<3 秒啟動爬取
- 記憶體使用：<500MB（處理 10,000 則留言）
- IndexedDB 配額：監控並在 80% 時警告
- 速率限制：遵守 Instagram/Facebook API 限制
- 繁體中文 UI：所有面向使用者的文字

**Scale/Scope**:  
- 預期使用者：10-50 位操作人員
- 資料規模：每位使用者 50-100 個貼文，每貼文平均 200-1000 則留言
- 並行爬取：最多 3 個貼文同時處理
- 資料保留：30 天或使用者手動清除

---

## 憲章合規檢查

*GATE: 必須在 Phase 0 研究前通過。Phase 1 設計後重新檢查。*

本功能必須符合所有憲章原則。逐項檢查：

### I. 程式碼品質與可維護性
- [x] Linting 和靜態分析已規劃：ESLint (TypeScript), Prettier
- [x] 程式碼複雜度將被監控（cyclomatic complexity <10）：使用 eslint-plugin-complexity
- [x] 技術債務追蹤計劃已定義：GitHub Issues + 每週審查
- [x] 程式碼審查檢查清單已準備：comprehensive.md（100 項）

### II. 測試標準與覆蓋率
- [x] 測試策略已定義（契約、整合、單元、效能）：詳見規格書 §Testing Standards
- [x] 目標覆蓋率 ≥80%（關鍵路徑 100%）：API 代理、爬蟲邏輯、狀態管理達 100%
- [x] TDD 方法已規劃：Phase 2 任務將優先撰寫測試
- [x] 效能回歸測試計劃已定義：Lighthouse CI 整合，監控載入時間和記憶體

### III. 用戶體驗一致性
- [x] 設計系統元件已識別：按鈕、輸入框、表格、模態對話框、Toast 通知、進度指示器
- [x] 錯誤處理和使用者回饋模式已定義：詳見規格書 22 個 FR
- [x] 無障礙需求已文件化（WCAG 2.1 AA）：鍵盤導航、ARIA 標籤、螢幕閱讀器支援
- [x] 載入狀態和效能回饋已規劃：>300ms 顯示 spinner，進度百分比，估計剩餘時間

### IV. 效能需求與優化
- [x] 效能目標已定義且可測量：詳見規格書 §Performance Requirements（10 個指標）
- [x] 資料庫索引策略已規劃：IndexedDB 使用複合索引（postId+timestamp）優化查詢
- [x] 快取策略已定義：使用者偏好（localStorage）、API 回應（記憶體快取 5 分鐘）
- [x] 效能監控計劃已建立：Vercel Analytics、Sentry 效能追蹤

### V. 文檔與本地化標準
- [x] 所有規格書使用繁體中文撰寫：spec.md 100% 繁體中文
- [x] 使用者故事和場景使用繁體中文：4 個故事全部繁體中文
- [x] UI 文字和錯誤訊息規劃為繁體中文：FR-017 明確要求
- [x] 術語詞彙表已準備：將在實作階段建立

**違規需要正當化**: 無違規項目

✅ **憲章檢查：全部通過**

---

## 專案結構

### 文件結構（本功能）

```text
specs/001-social-comment-scraper/
├── spec.md              # 功能規格書（已完成）
├── plan.md              # 本檔案（實作計劃）
├── research.md          # Phase 0 技術研究（本計劃產出）
├── data-model.md        # Phase 1 資料模型（本計劃產出）
├── quickstart.md        # Phase 1 快速開始指南（本計劃產出）
├── contracts/           # Phase 1 API 契約（本計劃產出）
│   ├── backend-api.yaml       # 後端代理 API 規格
│   └── graph-api-integration.yaml  # Graph API 整合契約
├── checklists/          # 品質檢查清單
│   └── comprehensive.md       # 需求品質檢查（已完成）
└── tasks.md             # Phase 2 任務清單（/speckit.tasks 產出）
```

### 原始碼結構（專案根目錄）

```text
social-comment-scraper/
├── frontend/                    # 前端 React 應用程式
│   ├── src/
│   │   ├── components/         # UI 元件
│   │   │   ├── common/         # 共用元件
│   │   │   │   ├── Button.tsx
│   │   │   │   ├── Input.tsx
│   │   │   │   ├── Toast.tsx
│   │   │   │   ├── Modal.tsx
│   │   │   │   └── ProgressBar.tsx
│   │   │   ├── scraper/        # 爬蟲相關元件
│   │   │   │   ├── UrlInput.tsx
│   │   │   │   ├── ScrapingProgress.tsx
│   │   │   │   └── BatchMode.tsx
│   │   │   ├── table/          # 表格編輯元件
│   │   │   │   ├── CommentsTable.tsx
│   │   │   │   ├── TableToolbar.tsx
│   │   │   │   ├── CustomFieldManager.tsx
│   │   │   │   └── SearchFilter.tsx
│   │   │   └── storage/        # 儲存管理元件
│   │   │       ├── QuotaWarning.tsx
│   │   │       └── StorageCleanup.tsx
│   │   ├── pages/              # 頁面元件
│   │   │   ├── Home.tsx        # 首頁（爬取介面）
│   │   │   ├── Editor.tsx      # 編輯頁面
│   │   │   └── History.tsx     # 歷史記錄
│   │   ├── services/           # 業務邏輯服務
│   │   │   ├── api/            # API 呼叫
│   │   │   │   ├── backend-client.ts    # 後端代理客戶端
│   │   │   │   ├── scraper-service.ts   # 爬蟲服務
│   │   │   │   └── url-parser.ts        # URL 解析
│   │   │   ├── storage/        # 儲存服務
│   │   │   │   ├── db.ts       # Dexie.js IndexedDB 設定
│   │   │   │   ├── comments-store.ts    # 留言儲存
│   │   │   │   ├── state-store.ts       # 爬取狀態儲存
│   │   │   │   └── quota-manager.ts     # 配額管理
│   │   │   ├── export/         # 匯出服務
│   │   │   │   └── excel-exporter.ts    # Excel 匯出
│   │   │   └── utils/          # 工具函式
│   │   │       ├── time-formatter.ts    # 時間格式化
│   │   │       ├── error-handler.ts     # 錯誤處理
│   │   │       └── undo-manager.ts      # 復原管理
│   │   ├── hooks/              # React Hooks
│   │   │   ├── useComments.ts
│   │   │   ├── useScraper.ts
│   │   │   └── useStorage.ts
│   │   ├── types/              # TypeScript 類型定義
│   │   │   ├── comment.ts
│   │   │   ├── post.ts
│   │   │   └── scraping-state.ts
│   │   ├── App.tsx             # 根元件
│   │   └── main.tsx            # 應用程式入口
│   ├── public/                 # 靜態資源
│   ├── tests/                  # 前端測試
│   │   ├── unit/               # 單元測試
│   │   ├── integration/        # 整合測試（Playwright）
│   │   └── mocks/              # Mock 資料（MSW）
│   ├── package.json
│   ├── vite.config.ts
│   ├── tsconfig.json
│   └── tailwind.config.js
│
├── api/                         # Vercel Serverless Functions（後端代理）
│   ├── instagram.ts            # Instagram API 代理端點
│   ├── facebook.ts             # Facebook API 代理端點
│   ├── _lib/                   # 共用函式庫
│   │   ├── rate-limiter.ts     # 速率限制
│   │   ├── token-manager.ts    # Token 管理
│   │   └── error-mapper.ts     # 錯誤映射
│   └── _tests/                 # 後端測試
│       └── api.test.ts
│
├── docs/                        # 額外文件
│   ├── api-documentation.md    # API 文件
│   └── deployment-guide.md     # 部署指南
│
├── .env.example                # 環境變數範本
├── .gitignore
├── package.json                # Root package.json（workspace）
├── vercel.json                 # Vercel 部署設定
└── README.md                   # 專案說明
```

**結構決策**: 採用 Option 2（Web application）結構，但調整為：
- `frontend/`：包含完整的 React SPA 應用程式
- `api/`：Vercel Serverless Functions（輕量後端代理）

此結構明確分離前後端職責，便於獨立開發和測試。前端為主要開發重點（~80% 工作量），後端僅作為安全的 API 代理層（~20% 工作量）。

---

## 複雜度追蹤

> **僅在憲章檢查有違規需要正當化時填寫**

*無需填寫 - 所有憲章檢查項目均已通過，無違規或例外情況。*

---

## Phase 0: 技術研究

請參閱 [research.md](./research.md) 以了解詳細的技術決策、替代方案評估和最佳實踐研究。

**研究重點**：
- Instagram/Facebook Graph API 端點和限制
- Serverless 平台選擇（Vercel vs AWS Lambda vs Cloudflare Workers）
- IndexedDB 最佳實踐和配額管理
- 表格編輯函式庫評估（AG Grid vs Handsontable vs react-data-grid）
- Excel 匯出函式庫（SheetJS vs ExcelJS）
- 自動續傳狀態機設計
- 速率限制演算法（Token Bucket vs Leaky Bucket）

---

## Phase 1: 設計

### 資料模型

請參閱 [data-model.md](./data-model.md) 以了解完整的 IndexedDB Schema、實體關聯和狀態轉換。

**核心實體**：
- Post（貼文）
- Comment（留言）
- ScrapingState（爬取狀態）
- CustomField（自訂欄位）
- OperationHistory（操作歷史）
- StorageQuotaStatus（儲存配額狀態）

### API 契約

請參閱 `contracts/` 目錄以了解完整的 API 規格：
- [backend-api.yaml](./contracts/backend-api.yaml)：後端代理層 RESTful API
- [graph-api-integration.yaml](./contracts/graph-api-integration.yaml)：Graph API 整合契約

**關鍵端點**：
- `POST /api/instagram/scrape`：爬取 Instagram 貼文留言
- `POST /api/facebook/scrape`：爬取 Facebook 貼文留言
- `GET /api/health`：服務健康檢查

### 快速開始指南

請參閱 [quickstart.md](./quickstart.md) 以了解開發環境設置、本地執行和測試流程。

---

## Phase 2: 任務分解

*任務分解將由 `/speckit.tasks` 命令生成 tasks.md*

預期任務階段：
- Phase 1: Setup（專案初始化、依賴安裝、環境設定）
- Phase 2: Foundation（後端 API 代理、IndexedDB schema、基礎 UI 元件）
- Phase 3: User Story 1 - 爬取功能（MVP）
- Phase 4: User Story 2 - 線上編輯
- Phase 5: User Story 3 - Excel 匯出
- Phase 6: User Story 4 - 批次處理
- Phase 7: Polish & 跨功能優化

---

## 憲章合規檢查（Phase 1 後重新檢查）

*Phase 1 設計完成後的檢查結果：*

### I. 程式碼品質與可維護性
- [x] ✅ Linting 設定已完成：ESLint + Prettier 配置檔案已準備
- [x] ✅ 複雜度監控已設置：eslint-plugin-complexity 規則已定義
- [x] ✅ 技術債務追蹤：GitHub Issues + Project Board
- [x] ✅ 程式碼審查流程：使用 comprehensive.md 檢查清單

### II. 測試標準與覆蓋率
- [x] ✅ 測試策略完整：契約（MSW）、整合（Playwright）、單元（Vitest）、效能（Lighthouse）
- [x] ✅ 覆蓋率目標：設定 Vitest 最低 80%，關鍵模組 100%
- [x] ✅ TDD 流程：tasks.md 將明確標註測試優先順序
- [x] ✅ 效能測試：Lighthouse CI 整合到 Vercel 部署流程

### III. 用戶體驗一致性
- [x] ✅ 設計系統：Tailwind CSS + 自訂元件庫（Button, Input, Modal 等）
- [x] ✅ 錯誤處理模式：Toast 通知系統 + 行內錯誤訊息 + 錯誤邊界
- [x] ✅ 無障礙：React ARIA + 語義化 HTML + 鍵盤快捷鍵
- [x] ✅ 載入狀態：Suspense + 進度條 + Skeleton screens

### IV. 效能需求與優化
- [x] ✅ 效能目標：詳見 Technical Context 和 research.md
- [x] ✅ IndexedDB 索引：複合索引優化查詢效能
- [x] ✅ 快取策略：API 回應快取、狀態快取、懶載入
- [x] ✅ 效能監控：Vercel Analytics + Sentry Performance

### V. 文檔與本地化標準
- [x] ✅ 本計劃使用繁體中文撰寫
- [x] ✅ 所有文件（research, data-model, quickstart）使用繁體中文
- [x] ✅ UI 文字規劃為繁體中文
- [x] ✅ 術語詞彙表將在實作階段建立

**重新檢查結果**: ✅ 全部通過，無違規

---

## 技術決策記錄

### 前端框架：React + TypeScript
**理由**：
- 生態系統成熟，套件豐富
- TypeScript 提供型別安全
- React 18 並行渲染優化大量資料效能
- 團隊熟悉度高（假設）

### 後端平台：Vercel Serverless Functions
**理由**：
- 與前端部署無縫整合
- 免費額度足夠（100GB-hours/月）
- 零維護成本
- 冷啟動時間短（<100ms）
- 全球 CDN 加速

### 表格編輯：AG Grid Community
**理由**：
- 免費開源
- 效能優異（可處理 10,000+ 行）
- 支援虛擬滾動、排序、篩選
- 完整的鍵盤導航
- 自訂欄位易於實作

### IndexedDB wrapper：Dexie.js
**理由**：
- 簡化 IndexedDB API
- 支援 Promise 和 async/await
- 自動處理版本升級
- 效能優異
- TypeScript 完整支援

### Excel 匯出：SheetJS (xlsx)
**理由**：
- 最成熟的純前端 Excel 函式庫
- 完整支援 .xlsx 格式
- 繁體中文無亂碼
- 效能穩定
- MIT 授權

### 時間處理：date-fns
**理由**：
- Tree-shakable（打包體積小）
- 函數式 API 易用
- 完整時區支援
- 格式化功能強大
- TypeScript 原生支援

### 樣式：Tailwind CSS
**理由**：
- Utility-first，開發快速
- 打包後體積小（只包含使用的類別）
- 響應式設計易於實作
- 維護性佳
- 設計一致性容易保持

---

## 部署策略

### 前端部署
- **平台**：Vercel
- **流程**：Git push → 自動部署
- **環境**：Production（main branch）、Preview（feature branches）
- **CDN**：全球分佈，邊緣快取

### 後端部署
- **平台**：Vercel Serverless Functions
- **區域**：自動選擇（通常 us-east-1）
- **環境變數**：
  - `INSTAGRAM_APP_TOKEN`：Instagram API Token
  - `FACEBOOK_APP_TOKEN`：Facebook API Token
  - `RATE_LIMIT_MAX`：最大並行請求數
- **監控**：Vercel Analytics + Sentry

### CI/CD 流程
```
1. Git Push to GitHub
2. Vercel 偵測變更
3. 執行測試（Vitest）
4. 建構前端（Vite build）
5. 部署 Functions
6. 執行 E2E 測試（Playwright）
7. Lighthouse 效能檢查
8. 部署完成
```

---

## 風險與緩解措施

### 風險 1: Instagram/Facebook API 審核未通過
**可能性**: 中  
**影響**: 高（阻擋專案進行）  
**緩解**：
- 提前準備完整的隱私政策和使用條款
- 明確說明商業使用目的（客戶意見分析）
- 準備備用方案（第三方服務如 CrowdTangle）

### 風險 2: API 速率限制影響使用體驗
**可能性**: 高  
**影響**: 中  
**緩解**：
- 實作智能排隊系統
- 顯示預估等待時間
- 限制並行爬取數量（3 個）
- 監控配額使用並提前警告使用者

### 風險 3: 大量資料導致瀏覽器效能問題
**可能性**: 中  
**影響**: 中  
**緩解**：
- 使用虛擬滾動（AG Grid 內建）
- 分頁載入（每次載入 100 則）
- Web Workers 處理資料轉換
- 實作配額警告和清理工具

### 風險 4: IndexedDB 配額不足
**可能性**: 中  
**影響**: 中  
**緩解**：
- 80% 警告機制
- 95% 強制清理
- 清理工具 UI
- 引導使用者定期匯出和清理

### 風險 5: 後端代理服務故障
**可能性**: 低  
**影響**: 高  
**緩解**：
- Vercel 99.99% SLA
- 健康檢查端點
- 前端顯示服務狀態
- 錯誤重試機制（最多 3 次）

---

## 下一步

1. ✅ **Phase 0 & 1 已完成**：本計劃、research.md、data-model.md、contracts/、quickstart.md
2. ⏭️ **執行 `/speckit.tasks`**：生成詳細的任務分解（tasks.md）
3. ⏭️ **開始實作**：按照 tasks.md 的順序執行
4. ⏭️ **持續集成**：設置 Vercel 自動部署和測試

---

**計劃完成日期**: 2025-11-19  
**下一個命令**: `/speckit.tasks` 生成任務清單
