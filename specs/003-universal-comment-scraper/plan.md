# 實作計劃：通用留言擷取工具

**Branch**: `003-universal-comment-scraper` | **Date**: 2025-11-20 | **Spec**: [spec.md](./spec.md)

## 摘要

開發一個通用的留言擷取工具，支援多個社群和內容平台。MVP階段專注於Facebook和Instagram（使用官方Graph API），提供智能平台識別、彈性認證選擇（API Token或帳號登入）、即時資料顯示和Excel匯出功能。採用模組化的平台適配器架構，為未來擴展到Medium、方格子等平台預留彈性。最終目標是Chrome擴充套件，但初期以網頁版本驗證核心價值。

**技術方案**：
- 前端：React + TypeScript，模組化平台適配器
- 後端：Vercel Serverless Functions（API代理 + Token保護）
- 擷取引擎：插件化設計，每個平台獨立模組
- 認證：多模式支援（API Token、模擬登入、無需認證）
- 儲存：IndexedDB + 擷取歷史管理

## 技術背景

**Language/Version**: TypeScript 5.2+, React 18+, Node.js 18+

**Primary Dependencies**:
- React, Vite, AG Grid, Dexie.js, SheetJS, Tailwind CSS
- Puppeteer（Chrome擴充時使用）
- Crypto-js（憑證加密）

**Storage**: IndexedDB（留言、憑證、歷史）

**Testing**: Vitest, Playwright, MSW

**Target Platform**: Web（MVP）→ Chrome Extension（V2）

**Project Type**: Web application（前端為主 + 輕量後端代理）

**Performance Goals**:
- 平台識別：<500ms
- API模式：10則/秒
- 爬蟲模式：1000則/<5分鐘
- 頁面載入：<2秒

**Constraints**:
- MVP僅FB+IG（4週）
- 法律合規優先（API>爬蟲）
- 帳密安全處理

## 憲章合規檢查

✅ 全部通過（同001專案標準）

## 專案結構

### MVP階段（FB + IG）

```
universal-scraper/
├── frontend/
│   ├── src/
│   │   ├── platforms/          # 平台適配器（核心）
│   │   │   ├── base/           # 基礎介面
│   │   │   │   ├── PlatformAdapter.ts  # 抽象基類
│   │   │   │   └── types.ts
│   │   │   ├── facebook/       # Facebook適配器
│   │   │   │   ├── FacebookAdapter.ts
│   │   │   │   ├── api-client.ts
│   │   │   │   └── url-parser.ts
│   │   │   ├── instagram/      # Instagram適配器
│   │   │   │   ├── InstagramAdapter.ts
│   │   │   │   ├── api-client.ts
│   │   │   │   └── url-parser.ts
│   │   │   └── registry.ts     # 平台註冊表
│   │   ├── services/
│   │   │   ├── auth/           # 認證管理
│   │   │   │   ├── token-manager.ts
│   │   │   │   ├── credential-store.ts（加密）
│   │   │   │   └── auth-validator.ts
│   │   │   ├── scraper/        # 擷取引擎
│   │   │   │   ├── scrape-engine.ts
│   │   │   │   ├── progress-tracker.ts
│   │   │   │   └── result-aggregator.ts
│   │   │   └── storage/
│   │   │       └── db.ts（Dexie）
│   │   ├── components/
│   │   └── pages/
│   └── tests/
├── api/                        # 後端代理
│   ├── facebook.ts
│   ├── instagram.ts
│   └── _lib/
└── docs/
```

## 關鍵技術決策

### 決策1: 平台適配器模式
- 每個平台獨立模組
- 統一介面（identify, authenticate, scrape）
- 易於新增平台

### 決策2: MVP範圍 = FB + IG
- 基於001專案經驗
- 4週完成
- 驗證核心概念

### 決策3: 認證多模式
- API Token（主要）
- 帳密模擬（備用）
- 無需認證（Medium等）

## 開發時程

**MVP（4週）**: FB + IG + 基本功能
**V2（+4週）**: Medium + 方格子 + 痞客邦
**V3（+2週）**: Chrome擴充套件

**總計**: 10週（2.5個月）

---

**計劃完成**: 2025-11-20

