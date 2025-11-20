# 快速開始：通用留言擷取工具

**日期**: 2025-11-20  
**MVP**: Facebook + Instagram

## 快速安裝

```bash
cd C:\Users\user\Desktop\Cursor\universal-scraper
pnpm create vite frontend --template react-ts
cd frontend
pnpm install
pnpm add dexie ag-grid-react xlsx axios crypto-js
pnpm add -D tailwindcss vitest playwright
pnpm dev
```

## 使用流程

### 使用者體驗

```
1. 打開工具
2. 輸入網址（FB或IG）
3. 系統識別平台
4. 輸入Token（或帳密）
5. 點擊「開始擷取」
6. 查看結果
7. 匯出Excel
```

## 開發路線圖

**Week 1**: 核心架構 + 平台適配器  
**Week 2**: FB適配器完整實作  
**Week 3**: IG適配器完整實作  
**Week 4**: UI整合 + 測試 + 部署  

**MVP完成**: Facebook + Instagram 自動擷取 ✅

**V2擴展**: Medium、方格子、痞客邦等

---

**完成**: 2025-11-20

