# 快速開始指南：社群留言爬蟲工具

**日期**: 2025-11-19  
**目的**: 幫助開發者快速建立開發環境、執行專案和開始貢獻

---

## 📋 前置需求

### 必要軟體

- ✅ **Node.js** 18+ ([下載](https://nodejs.org/))
- ✅ **npm** 9+ 或 **pnpm** 8+（推薦 pnpm，速度更快）
- ✅ **Git** 2.x+
- ✅ **現代瀏覽器**: Chrome 90+, Edge 90+, Firefox 88+, 或 Safari 14+
- ✅ **程式碼編輯器**: VS Code（推薦）

### 推薦 VS Code 擴充套件

- ESLint
- Prettier
- TypeScript Vue Plugin (Volar)
- Tailwind CSS IntelliSense
- Error Lens

### API 準備（開發前必須完成）

1. **Meta for Developers 帳號**
   - 註冊：https://developers.facebook.com/
   - 創建應用程式
   - 取得 App ID 和 App Secret

2. **API 權限申請**
   - Instagram: `instagram_basic`, `instagram_manage_comments`
   - Facebook: `pages_read_engagement`
   - 完成應用程式審核（提供隱私政策和使用條款）

3. **取得 App Access Token**
   ```bash
   # 公式
   GET https://graph.facebook.com/oauth/access_token?
     client_id={app-id}&
     client_secret={app-secret}&
     grant_type=client_credentials
   ```

---

## 🚀 快速開始（5 分鐘設置）

### 步驟 1: Clone 專案

```bash
# Clone 倉庫
git clone https://github.com/jokersosmart/Cursor.git
cd Cursor

# 切換到功能分支
git checkout 001-social-comment-scraper
```

### 步驟 2: 安裝依賴

```bash
# 使用 pnpm（推薦）
pnpm install

# 或使用 npm
npm install
```

**預計時間**: 2-3 分鐘

### 步驟 3: 設定環境變數

```bash
# 複製環境變數範本
cp .env.example .env.local

# 編輯 .env.local，填入你的 API Tokens
```

**`.env.local` 內容**:
```bash
# Instagram API
INSTAGRAM_APP_TOKEN=your_instagram_app_access_token_here

# Facebook API  
FACEBOOK_APP_TOKEN=your_facebook_app_access_token_here

# 速率限制設定
RATE_LIMIT_MAX_CALLS=180
RATE_LIMIT_WINDOW_MS=3600000

# Sentry（選用，用於錯誤追蹤）
SENTRY_DSN=your_sentry_dsn_here

# 環境
NODE_ENV=development
```

### 步驟 4: 啟動開發伺服器

```bash
# 同時啟動前端和後端（推薦）
pnpm dev

# 或分別啟動
pnpm dev:frontend  # http://localhost:5173
pnpm dev:api       # Vercel Functions 本地模擬
```

### 步驟 5: 開啟瀏覽器測試

```
前端：http://localhost:5173
API 健康檢查：http://localhost:3000/api/health
```

**預期看到**:
- 首頁顯示網址輸入框和「開始爬取」按鈕
- 所有 UI 文字為繁體中文
- API 健康檢查返回 `{"status": "ok"}`

---

## 📁 專案結構導覽

```
social-comment-scraper/
├── frontend/                    # 前端應用程式
│   ├── src/
│   │   ├── components/         # React 元件
│   │   ├── pages/              # 頁面元件
│   │   ├── services/           # 業務邏輯
│   │   ├── hooks/              # 自訂 Hooks
│   │   └── types/              # TypeScript 類型
│   ├── tests/                  # 測試
│   └── package.json
│
├── api/                         # Vercel Serverless Functions
│   ├── instagram.ts            # Instagram 代理端點
│   ├── facebook.ts             # Facebook 代理端點
│   ├── health.ts               # 健康檢查
│   └── _lib/                   # 共用函式庫
│
├── specs/001-social-comment-scraper/  # 規格文件
│   ├── spec.md                 # 功能規格書
│   ├── plan.md                 # 實作計劃
│   ├── research.md             # 技術研究
│   ├── data-model.md           # 資料模型
│   └── contracts/              # API 契約
│
└── docs/                        # 專案文件
```

---

## 🛠️ 常用開發指令

### 開發

```bash
# 啟動開發伺服器（前端 + 後端）
pnpm dev

# 僅啟動前端
pnpm dev:frontend

# 本地測試 Serverless Functions
vercel dev
```

### 測試

```bash
# 執行所有測試
pnpm test

# 執行前端單元測試
pnpm test:unit

# 執行 E2E 整合測試
pnpm test:e2e

# 測試覆蓋率報告
pnpm test:coverage

# 監看模式（開發時使用）
pnpm test:watch
```

### 程式碼品質

```bash
# Lint 檢查
pnpm lint

# 自動修復 Lint 問題
pnpm lint:fix

# 格式化程式碼
pnpm format

# 型別檢查
pnpm type-check
```

### 建構

```bash
# 建構生產版本
pnpm build

# 預覽建構結果
pnpm preview
```

### 部署

```bash
# 部署到 Vercel（需先安裝 Vercel CLI）
vercel

# 部署到 Production
vercel --prod
```

---

## 🧪 測試指南

### 單元測試範例

**測試 URL 解析函式**:
```typescript
// frontend/src/services/api/url-parser.test.ts
import { describe, it, expect } from 'vitest';
import { parseInstagramUrl } from './url-parser';

describe('parseInstagramUrl', () => {
  it('應正確解析標準 Instagram 網址', () => {
    const result = parseInstagramUrl('https://www.instagram.com/p/ABC123/');
    expect(result).toBe('ABC123');
  });
  
  it('應拒絕無效網址', () => {
    const result = parseInstagramUrl('https://invalid-url.com');
    expect(result).toBeNull();
  });
});
```

### 整合測試範例

**測試爬取流程**:
```typescript
// frontend/tests/integration/scraping.spec.ts
import { test, expect } from '@playwright/test';

test('使用者可以爬取 Instagram 貼文留言', async ({ page }) => {
  // 前往首頁
  await page.goto('http://localhost:5173');
  
  // 輸入測試網址
  await page.fill('[data-testid="url-input"]', 
    'https://www.instagram.com/p/TEST123/');
  
  // 點擊爬取按鈕
  await page.click('[data-testid="scrape-button"]');
  
  // 等待進度指示器出現
  await expect(page.locator('[data-testid="progress"]')).toBeVisible();
  
  // 等待留言顯示
  await expect(page.locator('[data-testid="comments-table"]')).toBeVisible();
  
  // 驗證留言數量 > 0
  const rows = await page.locator('[data-testid="comment-row"]').count();
  expect(rows).toBeGreaterThan(0);
});
```

### 契約測試範例

**使用 MSW 模擬 API**:
```typescript
// frontend/tests/mocks/handlers.ts
import { rest } from 'msw';

export const handlers = [
  rest.post('/api/instagram/scrape', (req, res, ctx) => {
    return res(
      ctx.status(200),
      ctx.json({
        success: true,
        data: {
          comments: [/* mock data */],
          paging: { cursors: { after: 'next' } }
        }
      })
    );
  })
];
```

---

## 🐛 除錯指南

### 常見問題與解決方案

#### 問題 1: API Token 無效

**症狀**: 
```
錯誤：認證失敗，請聯繫技術支援
```

**解決方案**:
1. 檢查 `.env.local` 中的 Token 是否正確
2. 驗證 Token 是否過期（在 Meta Developers 檢查）
3. 確認應用程式審核狀態（是否已通過）

**驗證 Token**:
```bash
# 測試 Instagram Token
curl "https://graph.facebook.com/v18.0/me?access_token=YOUR_TOKEN"

# 測試 Facebook Token  
curl "https://graph.facebook.com/v18.0/debug_token?input_token=YOUR_TOKEN&access_token=YOUR_TOKEN"
```

#### 問題 2: CORS 錯誤

**症狀**:
```
Access to fetch at 'http://localhost:3000/api/...' from origin 'http://localhost:5173' has been blocked by CORS policy
```

**解決方案**:
1. 確認後端 API 已設定 CORS headers
2. 檢查 `vercel.json` 設定
3. 本地開發使用 Vercel CLI: `vercel dev`

#### 問題 3: IndexedDB 無法開啟

**症狀**:
```
錯誤：無法開啟資料庫
```

**解決方案**:
1. 清除瀏覽器資料（開發工具 > Application > Clear storage）
2. 檢查瀏覽器是否支援 IndexedDB
3. 使用無痕模式測試（排除擴充套件干擾）

#### 問題 4: 中文顯示亂碼

**症狀**:
留言內容或 UI 文字顯示為 `???` 或亂碼

**解決方案**:
1. 確認所有檔案使用 UTF-8 編碼儲存
2. 檢查 API 回應的 `Content-Type: application/json; charset=utf-8`
3. Excel 匯出使用 UTF-8 BOM

---

## 📊 開發工作流程

### 功能開發流程

```
1. 從 tasks.md 選擇一個任務
   ↓
2. 建立功能分支
   git checkout -b feature/task-id-description
   ↓
3. 撰寫測試（TDD）
   - 撰寫失敗的測試
   - 執行測試確認失敗
   ↓
4. 實作功能
   - 撰寫最小程式碼使測試通過
   - 重構優化
   ↓
5. 執行所有測試
   pnpm test
   ↓
6. Commit 變更
   git add .
   git commit -m "feat: 實作任務說明"
   ↓
7. 推送並建立 PR
   git push origin feature/task-id-description
```

### Git Commit 訊息規範

遵循 Conventional Commits：

```bash
# 新增功能
git commit -m "feat: 新增 Instagram 爬蟲功能"

# 修復 Bug
git commit -m "fix: 修正時間格式顯示錯誤"

# 文件更新
git commit -m "docs: 更新 API 文件"

# 樣式調整
git commit -m "style: 調整按鈕間距"

# 重構
git commit -m "refactor: 重構資料存取層"

# 測試
git commit -m "test: 新增爬蟲服務單元測試"

# 建構工具
git commit -m "build: 更新 Vite 設定"
```

---

## 🎯 第一個任務：驗證環境設置

### 任務目標
確認開發環境正確設置，所有依賴正常運作。

### 步驟

#### 1. 驗證 Node.js 版本
```bash
node --version
# 應顯示：v18.x.x 或更高
```

#### 2. 驗證套件安裝
```bash
pnpm install
# 應無錯誤，顯示已安裝套件數量
```

#### 3. 啟動開發伺服器
```bash
pnpm dev
# 前端：http://localhost:5173
# 後端：http://localhost:3000/api
```

#### 4. 執行測試
```bash
pnpm test
# 應顯示：All tests passed
```

#### 5. 驗證 API 健康檢查
```bash
curl http://localhost:3000/api/health
# 應返回：{"status":"ok", ...}
```

#### 6. 驗證前端畫面
- 開啟 http://localhost:5173
- 應看到網址輸入框
- 所有文字應為繁體中文
- 無 Console 錯誤

✅ **環境設置成功！**

---

## 💻 開發環境設定

### VS Code 工作區設定

建立 `.vscode/settings.json`:

```json
{
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true
  },
  "typescript.tsdk": "node_modules/typescript/lib",
  "typescript.enablePromptUseWorkspaceTsd": true,
  "[typescript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[typescriptreact]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  }
}
```

### ESLint 設定

**frontend/.eslintrc.json**:
```json
{
  "extends": [
    "eslint:recommended",
    "plugin:@typescript-eslint/recommended",
    "plugin:react/recommended",
    "plugin:react-hooks/recommended",
    "prettier"
  ],
  "plugins": ["@typescript-eslint", "react", "complexity"],
  "rules": {
    "complexity": ["error", 10],
    "max-lines-per-function": ["warn", 50],
    "no-console": ["warn", { "allow": ["warn", "error"] }]
  }
}
```

### Prettier 設定

**frontend/.prettierrc**:
```json
{
  "semi": true,
  "singleQuote": true,
  "trailingComma": "es5",
  "printWidth": 100,
  "tabWidth": 2
}
```

---

## 🧪 測試場景

### 測試場景 1: 爬取 Instagram 公開貼文

**目的**: 驗證基本爬取功能

**步驟**:
1. 啟動開發伺服器
2. 前往 http://localhost:5173
3. 貼上測試用 Instagram 網址：`https://www.instagram.com/p/[測試貼文ID]/`
4. 點擊「開始爬取」
5. 觀察進度指示器
6. 確認留言顯示在表格中

**預期結果**:
- ✅ 進度指示器顯示「已擷取 X 則留言」
- ✅ 表格顯示留言者、內容、時間、按讚數
- ✅ 時間格式為「2025-11-18 18:30」（本地時間）
- ✅ 所有文字為繁體中文

### 測試場景 2: 線上編輯留言

**目的**: 驗證表格編輯功能

**步驟**:
1. 完成場景 1（確保有留言資料）
2. 點擊任一留言的儲存格
3. 修改內容（例如新增「重要」標記）
4. 按 Enter 或點擊外部儲存
5. 重新載入頁面

**預期結果**:
- ✅ 編輯即時生效，顯示「已儲存」提示
- ✅ 重新載入後編輯內容保留
- ✅ IndexedDB 中的資料已更新

### 測試場景 3: Excel 匯出

**目的**: 驗證匯出功能和中文支援

**步驟**:
1. 確保表格中有留言資料
2. 點擊「匯出 Excel」按鈕
3. 等待檔案下載
4. 在 Excel 中開啟檔案

**預期結果**:
- ✅ 檔案名稱：`留言資料_20251119_1030.xlsx`
- ✅ 所有欄位正確對應
- ✅ 繁體中文無亂碼
- ✅ 時間格式一致

### 測試場景 4: 網路中斷恢復

**目的**: 驗證自動續傳機制

**步驟**:
1. 開始爬取一個有大量留言的貼文（>1000 則）
2. 爬取進行中時，開啟瀏覽器開發工具
3. Network tab > Offline（模擬斷網）
4. 觀察錯誤訊息
5. 恢復網路
6. 重新整理頁面

**預期結果**:
- ✅ 顯示「連線中斷，已保存部分資料」
- ✅ 重新整理後顯示「偵測到未完成的爬取任務，要繼續嗎？」
- ✅ 點擊「繼續」後從中斷處恢復
- ✅ 無重複留言

---

## 📦 部署指南

### 部署到 Vercel（Production）

#### 前置準備

1. **安裝 Vercel CLI**
   ```bash
   npm install -g vercel
   ```

2. **登入 Vercel**
   ```bash
   vercel login
   ```

3. **設定環境變數**（在 Vercel Dashboard）
   - Project Settings > Environment Variables
   - 新增 `INSTAGRAM_APP_TOKEN`
   - 新增 `FACEBOOK_APP_TOKEN`
   - 環境：Production, Preview, Development

#### 部署步驟

```bash
# 初次部署（會建立 Vercel 專案）
vercel

# 後續部署到 Production
vercel --prod

# 或使用 Git 整合（推薦）
git push origin 001-social-comment-scraper
# Vercel 自動部署 Preview
```

#### 驗證部署

1. **檢查健康狀態**
   ```
   https://your-app.vercel.app/api/health
   ```

2. **測試前端**
   ```
   https://your-app.vercel.app
   ```

3. **測試爬取功能**
   - 使用真實的公開貼文網址
   - 確認功能正常運作

---

## 🔍 除錯技巧

### 前端除錯

**React DevTools**:
- 安裝 React DevTools 瀏覽器擴充套件
- Components tab 查看元件狀態
- Profiler tab 分析效能瓶頸

**Dexie.js 除錯**:
```typescript
// 啟用 Dexie 除錯模式
import Dexie from 'dexie';

Dexie.debug = true; // 在開發環境啟用

// 查看所有資料
await db.comments.toArray();
await db.posts.toArray();
```

**IndexedDB 檢視器**:
- 瀏覽器開發工具 > Application > IndexedDB
- 可直接查看、編輯、刪除資料

### 後端除錯

**Vercel Functions 本地除錯**:
```bash
# 使用 Vercel CLI 本地執行
vercel dev --debug

# 查看詳細日誌
```

**Console 日誌**:
```typescript
// api/instagram.ts
export default async function handler(req, res) {
  console.log('[Instagram API] Request:', req.body);
  
  try {
    const result = await scrapeInstagram(req.body);
    console.log('[Instagram API] Success:', result.data.length);
    return res.json(result);
  } catch (error) {
    console.error('[Instagram API] Error:', error);
    return res.status(500).json({ error: error.message });
  }
}
```

### 效能分析

**Lighthouse**:
```bash
# 分析生產版本
pnpm build
pnpm preview
# 開啟 Chrome DevTools > Lighthouse > Run
```

**Vite 分析**:
```bash
# 分析 bundle 大小
pnpm build --mode analyze
```

---

## 📚 參考文件

### 內部文件
- [功能規格書](./spec.md) - 需求和使用者故事
- [實作計劃](./plan.md) - 技術方案和架構
- [技術研究](./research.md) - 技術調查和決策
- [資料模型](./data-model.md) - IndexedDB Schema
- [API 契約](./contracts/) - API 規格
- [品質檢查清單](./checklists/comprehensive.md) - 需求品質驗證

### 外部參考
- [Instagram Graph API](https://developers.facebook.com/docs/instagram-api)
- [Facebook Graph API](https://developers.facebook.com/docs/graph-api)
- [Dexie.js 文件](https://dexie.org/)
- [AG Grid React](https://www.ag-grid.com/react-data-grid/)
- [SheetJS 文件](https://docs.sheetjs.com/)
- [Vercel Functions](https://vercel.com/docs/functions)

---

## 🎯 MVP 快速實作指南（P1 Story）

**目標**: 3 天內完成最小可行產品

### Day 1: 後端 + 基礎設置
- ✅ 專案初始化（Vite + React）
- ✅ 後端 API 代理實作（instagram.ts, facebook.ts）
- ✅ IndexedDB Schema（Dexie.js）
- ✅ 環境變數設定
- ✅ 基礎 UI 元件（Button, Input）

### Day 2: 爬取核心功能
- ✅ URL 輸入和驗證
- ✅ 爬取服務實作
- ✅ 進度指示器
- ✅ 錯誤處理
- ✅ 表格顯示留言

### Day 3: 測試和優化
- ✅ 單元測試（覆蓋率 >80%）
- ✅ 整合測試（爬取流程）
- ✅ 錯誤處理完善
- ✅ UI 優化和無障礙
- ✅ 部署到 Vercel

**MVP 交付標準**:
- [ ] 可爬取 Instagram 和 Facebook 公開貼文
- [ ] 留言顯示在表格中（含時間、內容、按讚數）
- [ ] 錯誤訊息繁體中文且友善
- [ ] 測試覆蓋率 ≥80%
- [ ] 部署到 Vercel 可公開存取

---

## 🤝 團隊協作

### 分工建議

**前端開發者**:
- UI 元件開發
- 表格編輯功能
- Excel 匯出
- 無障礙實作

**後端開發者**:
- API 代理層
- 速率限制邏輯
- 錯誤處理映射
- 監控和日誌

**全端開發者**（單人專案）:
- 按照 tasks.md 順序執行
- 優先完成 Foundation + P1 Story
- 其他故事按優先順序迭代

### Code Review 清單

審查 PR 時檢查：
- [ ] 程式碼符合 ESLint 規則
- [ ] 測試覆蓋率符合標準
- [ ] 繁體中文訊息正確無誤
- [ ] 無 Console 錯誤或警告
- [ ] 效能無明顯退化
- [ ] 符合憲章五項原則
- [ ] Commit 訊息符合規範

---

## 🆘 取得幫助

### 問題回報

1. **檢查現有 Issues**: https://github.com/jokersosmart/Cursor/issues
2. **建立新 Issue**: 使用 Issue 範本，提供詳細資訊
3. **提供資訊**:
   - 環境（OS, Browser, Node 版本）
   - 重現步驟
   - 預期 vs 實際結果
   - 錯誤訊息和 Stack Trace
   - 螢幕截圖

### 開發疑問

- 查看 [research.md](./research.md) 了解技術決策理由
- 查看 [data-model.md](./data-model.md) 了解資料結構
- 查看 [comprehensive.md](./checklists/comprehensive.md) 了解品質標準

---

## ✅ 下一步

完成環境設置後：

1. **閱讀文件** ✓
   - [x] 功能規格書
   - [x] 實作計劃
   - [x] 快速開始指南（本檔案）

2. **執行命令生成任務清單** ⏭️
   ```
   @speckit.tasks.agent.md
   ```

3. **開始實作** ⏭️
   - 按照 tasks.md 執行
   - 優先完成 MVP（P1 Story）

---

**文件版本**: 1.0.0  
**最後更新**: 2025-11-19  
**維護者**: 開發團隊

🎉 **準備好開始開發了！祝編碼愉快！**

