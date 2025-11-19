# 實作計劃：社群留言編輯工具（檔案上傳版）

**Branch**: `002-comment-editor-upload` | **Date**: 2025-11-19 | **Spec**: [spec.md](./spec.md)  
**版本**: 2.0（無需 API 版本）  
**原始版本**: 001-social-comment-scraper（已簡化）

## 摘要

本專案開發一個純前端的社群留言編輯工具，讓非技術背景的操作人員能輕鬆整理和分析社群留言資料。使用者透過上傳 CSV、Excel 或 JSON 檔案（或手動貼上資料），將留言匯入系統，提供直覺的線上編輯介面、強大的搜尋篩選功能，以及一鍵 Excel 匯出。

**核心優勢**：
- 🚀 **立即可用**: 無需 API 申請和審核，部署即可使用
- 🔒 **隱私優先**: 純前端處理，資料不離開使用者裝置
- ⚡ **極簡架構**: 無後端、無伺服器、零維護成本
- 💰 **零成本**: 靜態託管免費，無 API 配額限制
- 🎯 **開發快速**: 4-5 天完成 MVP，無需等待審核

**技術方案重點**：
- 純前端：React + TypeScript SPA
- 檔案解析：Papa Parse (CSV) + SheetJS (Excel)
- 表格編輯：AG Grid Community
- 儲存：Dexie.js (IndexedDB)
- Excel 匯出：SheetJS
- 部署：Vercel/GitHub Pages（靜態網站）

---

## 技術背景

**Language/Version**: 
- TypeScript 5.2+
- React 18+
- Node.js 18+（僅用於建構，不需要 runtime）

**Primary Dependencies**:  
- React, Vite
- AG Grid Community（表格）
- SheetJS / xlsx（Excel 讀寫）
- Papa Parse（CSV 解析）
- Dexie.js（IndexedDB）
- date-fns（時間處理）
- Tailwind CSS（樣式）

**Storage**:  
- IndexedDB（透過 Dexie.js）：所有留言資料
- localStorage：使用者偏好設定

**Testing**:  
- Vitest（單元測試）
- Playwright（整合測試）
- Lighthouse CI（效能測試）

**Target Platform**:  
- Web 應用程式（純前端 SPA）
- 目標瀏覽器：Chrome 90+, Edge 90+, Firefox 88+, Safari 14+
- 部署：任何靜態託管服務

**Project Type**: 單頁前端應用（Single project - 純前端）

**Performance Goals**:  
- 頁面初次載入：<2 秒
- 檔案解析：1000 則 <3 秒
- 表格編輯回應：<100ms
- Excel 匯出：1000 則 <5 秒
- 前端 bundle：<250KB gzipped

**Constraints**:  
- 檔案大小限制：建議 <10MB（約 20,000 則留言）
- 記憶體使用：<500MB（處理 10,000 則）
- 僅前端：無後端 API
- 離線可用：首次載入後

**Scale/Scope**:  
- 預期使用者：不限（純前端可無限擴展）
- 單次資料規模：建議 5,000-10,000 則留言
- 無並行限制（純本地處理）

---

## 憲章合規檢查

### I. 程式碼品質與可維護性
- [x] Linting 和靜態分析已規劃：ESLint (TypeScript), Prettier
- [x] 程式碼複雜度將被監控：<10
- [x] 技術債務追蹤計劃：GitHub Issues
- [x] 程式碼審查流程：標準 PR 流程

### II. 測試標準與覆蓋率
- [x] 測試策略已定義：單元、整合、效能測試
- [x] 目標覆蓋率 ≥80%（檔案解析 100%）
- [x] TDD 方法已規劃
- [x] 效能測試計劃：Lighthouse CI

### III. 用戶體驗一致性
- [x] 設計系統元件已識別
- [x] 錯誤處理已定義
- [x] 無障礙需求已文件化（WCAG 2.1 AA）
- [x] 載入狀態已規劃

### IV. 效能需求與優化
- [x] 效能目標已定義且可測量
- [x] IndexedDB 索引策略已規劃
- [x] 快取策略：檔案解析結果快取
- [x] 效能監控：Vercel Analytics

### V. 文檔與本地化標準
- [x] 所有規格書使用繁體中文
- [x] 使用者故事使用繁體中文
- [x] UI 文字規劃為繁體中文

**憲章檢查：全部通過** ✅

---

## 專案結構

### 文件結構

```text
specs/002-comment-editor-upload/
├── spec.md              # 功能規格書（新版）
├── plan.md              # 本檔案（實作計劃）
└── tasks.md             # 任務清單（即將生成）
```

### 原始碼結構（純前端）

```text
comment-editor/
├── src/
│   ├── components/         # React 元件
│   │   ├── common/         # 共用元件
│   │   │   ├── Button.tsx
│   │   │   ├── Input.tsx
│   │   │   └── Modal.tsx
│   │   ├── upload/         # 上傳相關
│   │   │   ├── FileUploader.tsx
│   │   │   ├── DataPaster.tsx
│   │   │   ├── FieldMapper.tsx
│   │   │   └── ImportProgress.tsx
│   │   ├── table/          # 表格編輯
│   │   │   ├── CommentsTable.tsx
│   │   │   ├── TableToolbar.tsx
│   │   │   └── CustomFieldManager.tsx
│   │   └── export/         # 匯出功能
│   │       └── ExportButton.tsx
│   ├── services/           # 業務邏輯
│   │   ├── parsers/        # 檔案解析
│   │   │   ├── csv-parser.ts
│   │   │   ├── excel-parser.ts
│   │   │   ├── json-parser.ts
│   │   │   └── field-mapper.ts
│   │   ├── storage/        # IndexedDB
│   │   │   ├── db.ts
│   │   │   ├── comments-store.ts
│   │   │   └── quota-manager.ts
│   │   ├── export/         # 匯出
│   │   │   └── excel-exporter.ts
│   │   └── utils/          # 工具
│   │       ├── date-parser.ts
│   │       └── validator.ts
│   ├── hooks/              # Custom Hooks
│   ├── types/              # TypeScript 類型
│   ├── App.tsx
│   └── main.tsx
├── tests/                  # 測試
├── public/                 # 靜態資源
├── package.json
├── vite.config.ts
└── tailwind.config.js
```

**結構決策**: 純前端單頁應用，所有邏輯在 `src/` 目錄，無 `api/` 或 `backend/` 目錄

---

## 關鍵技術決策

### 決策 1: 純前端架構 ✅

**理由**: 
- 無需後端，零維護成本
- 部署簡單（靜態檔案）
- 完全離線可用（PWA 潛力）
- 隱私保護最佳

### 決策 2: 多格式檔案解析 ✅

**支援格式**: CSV, Excel (.xlsx), JSON

**解析工具**:
- **CSV**: Papa Parse（最受歡迎，7.5k stars）
- **Excel**: SheetJS（同時用於讀取和匯出）
- **JSON**: 原生 JSON.parse

**理由**: 涵蓋最常見的資料交換格式

### 決策 3: 智能欄位對應 ✅

**功能**: 自動辨識欄位名稱（留言/comment/評論都能認）

**理由**: 
- 使用者可能用不同名稱
- 自動對應降低使用門檻
- 手動對應作為備案

### 決策 4: 內建範例資料 ✅

**功能**: 提供「載入範例資料」按鈕，100 則範例留言

**理由**:
- 降低首次使用門檻
- 展示功能用
- 教學和測試用

---

## 簡化的時程估算

### 開發時程（純前端，更快！）

| 階段 | 工作項目 | 估計時間 |
|------|---------|---------|
| Setup | 專案建立、依賴安裝 | 0.5 天 |
| Foundation | IndexedDB、基礎元件 | 1 天 |
| P1 匯入功能 | 檔案上傳、解析、驗證 | 1.5 天 |
| P2 範例資料 | 內建 Mock 資料 | 0.5 天 |
| P3 編輯功能 | 表格編輯、搜尋篩選 | 1.5 天 |
| P4 匯出功能 | Excel 匯出 | 1 天 |
| Polish | 測試、優化、文件 | 1 天 |
| **總計** | | **7 天** |

**MVP 時程**（P1 + P2 + P3）: **4 天**

**vs 原版**: 14.5 天 → 7 天（節省 50%！）

---

## 技術堆疊（簡化版）

| 類別 | 技術選擇 | 用途 |
|------|---------|------|
| 框架 | React 18 | UI 渲染 |
| 語言 | TypeScript 5.2+ | 型別安全 |
| 建構 | Vite 5 | 快速建構 |
| 表格 | AG Grid Community | 表格編輯 |
| CSV | Papa Parse | CSV 解析 |
| Excel | SheetJS (xlsx) | Excel 讀寫 |
| 儲存 | Dexie.js | IndexedDB |
| 時間 | date-fns | 日期解析和格式化 |
| 樣式 | Tailwind CSS | UI 樣式 |
| 測試 | Vitest + Playwright | 測試 |

**無需**:
- ❌ 後端框架
- ❌ API 客戶端
- ❌ 速率限制
- ❌ Token 管理
- ❌ Serverless Functions

---

## 風險與緩解（大幅降低！）

### 風險 1: 檔案格式多樣性
**可能性**: 中  
**影響**: 中  
**緩解**：智能欄位對應 + 清楚的格式說明 + 範例檔案下載

### 風險 2: 大檔案效能
**可能性**: 中  
**影響**: 中  
**緩解**：分批處理、Web Workers、虛擬滾動

### 風險 3: 使用者需手動準備資料
**可能性**: 高  
**影響**: 低  
**緩解**：提供清楚的資料準備指引 + 範例資料體驗

**總體風險**: 大幅降低（無 API、無後端、無審核）✅

---

## 與原版本對比

| 項目 | 原版（API 爬取）| 新版（檔案上傳）| 差異 |
|------|---------------|----------------|------|
| 開發時間 | 14.5 天 + 審核 | **7 天** | ✅ 快 50% |
| 技術複雜度 | 高（前後端分離）| **低（純前端）** | ✅ 簡單 |
| 需要 API | ✅ 需要 | **❌ 不需要** | ✅ 無阻礙 |
| 需要審核 | ✅ 3-5 天 | **❌ 無** | ✅ 立即可用 |
| 維護成本 | 中（後端 + API）| **零（靜態網站）** | ✅ 省成本 |
| 使用門檻 | 低（貼網址）| 中（準備檔案）| ⚠️ 稍高 |
| 部署 | Vercel Functions | **靜態託管** | ✅ 更簡單 |
| 適用場景 | 自動化大量爬取 | **手動收集後整理** | 不同定位 |

---

## 下一步

1. ✅ **新版 spec.md 已完成**
2. ✅ **新版 plan.md 已完成**（本檔案）
3. ⏭️ **生成新版 tasks.md**（簡化為 ~50 個任務）
4. ⏭️ **開始實作**（4 天完成 MVP）

---

**計劃完成時間**: 2025-11-19  
**預估總時程**: 7 天完整功能，4 天 MVP  
**下一步**: 生成任務清單

