# 社群留言爬蟲工具

線上工具，協助操作人員從 Instagram 和 Facebook 公開貼文爬取留言資料，提供編輯和 Excel 匯出功能。

## 功能特色

- 🌐 支援 Instagram 和 Facebook 公開貼文
- 📊 即時顯示爬取進度
- ✏️ 線上表格編輯（新增欄位、刪除、搜尋）
- 📥 一鍵匯出 Excel（繁體中文無亂碼）
- ⚡ 批次處理多個貼文
- 🔄 自動續傳機制（網路中斷恢復）
- 💾 本地儲存（IndexedDB）
- 🌏 100% 繁體中文介面

## 技術架構

- **前端**: React 18 + TypeScript + Vite + Tailwind CSS
- **表格**: AG Grid Community
- **儲存**: Dexie.js (IndexedDB)
- **後端**: Vercel Serverless Functions
- **API**: Instagram/Facebook Graph API

## 快速開始

詳細步驟請參閱：
- [開發環境準備指南](./開發環境準備指南.md)
- [Meta API 申請指南](./Meta-API-申請完整指南.md)
- [任務執行指南](./任務執行實戰指南.md)

## 文件

完整規劃文件位於：`../specs/001-social-comment-scraper/`

- [功能規格書](../specs/001-social-comment-scraper/spec.md)
- [實作計劃](../specs/001-social-comment-scraper/plan.md)
- [技術研究](../specs/001-social-comment-scraper/research.md)
- [資料模型](../specs/001-social-comment-scraper/data-model.md)
- [任務清單](../specs/001-social-comment-scraper/tasks.md)

## License

MIT

