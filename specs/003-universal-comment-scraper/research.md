# 技術研究：通用留言擷取工具

**日期**: 2025-11-20  
**範圍**: MVP（Facebook + Instagram）

## 1. 平台適配器設計模式

### 決策：採用Adapter Pattern + Strategy Pattern

**評估的架構**:
- Adapter Pattern（適配器模式）✅ 選用
- Factory Pattern（工廠模式）
- Plugin Architecture（插件架構）

**選擇理由**:
- 統一介面，每個平台獨立實作
- 易於測試和維護
- 新增平台只需實作3個核心方法
- 符合開放封閉原則

**核心介面設計**:
```typescript
interface PlatformAdapter {
  // 識別網址是否屬於此平台
  identify(url: string): boolean;
  
  // 處理認證
  authenticate(credentials: AuthCredentials): Promise<AuthResult>;
  
  // 執行擷取
  scrape(url: string, options: ScrapeOptions): AsyncIterator<Comment>;
}
```

---

## 2. Facebook vs Instagram API差異

### Facebook Graph API
**端點**: `/v18.0/{post-id}/comments`  
**配額**: ~200 calls/hour  
**欄位**: `from{name,id}, message, created_time, like_count`  
**分頁**: cursor-based  

### Instagram Graph API
**端點**: `/v18.0/{media-id}/comments`  
**配額**: ~200 calls/hour  
**欄位**: `username, text, timestamp, like_count`  
**分頁**: cursor-based  
**限制**: 需要Business/Creator帳號

**統一資料結構**:
```typescript
interface UnifiedComment {
  platform: 'facebook' | 'instagram';
  commenter: string;        // FB: from.name, IG: username
  content: string;          // FB: message, IG: text
  timestamp: Date;          // 統一為Date物件
  likes: number;
  sourceUrl: string;
}
```

---

## 3. 認證管理與安全

### Token加密儲存

**選擇**: AES-256-GCM加密

**實作**:
```typescript
import CryptoJS from 'crypto-js';

// 加密（使用裝置指紋作為金鑰）
const encrypted = CryptoJS.AES.encrypt(token, deviceId);

// 儲存到IndexedDB
await db.tokens.add({ platform: 'facebook', encrypted });
```

**安全原則**:
- Token從不明文儲存
- 使用時才解密
- 記憶體中立即清除

---

## 4. 後端代理層設計

### 決策：輕量Serverless Functions

**職責**:
- 保護Token（環境變數）
- 代理API呼叫
- 速率限制管理
- CORS處理

**vs 重後端**:
- 不選：Express + Database（過度設計）
- 選用：Vercel Functions（輕量、零維護）

---

## 5. 平台擴展策略（V2）

### 研究結論

**Medium**: 
- 有官方API（需申請）
- 或網頁爬蟲（公開文章可行）

**方格子（Vocus）**:
- 無官方API
- 需網頁爬蟲
- HTML結構相對穩定

**痞客邦（Pixnet）**:
- 有API但需商業合作
- 網頁爬蟲可行（公開內容）

**通用模式**:
- 提供CSS Selector配置
- 使用者自定義抓取規則

---

## 6. Chrome擴充套件架構（V3）

### Manifest V3

**核心元件**:
```
manifest.json（配置）
├── background.js（Service Worker）
├── content.js（注入腳本）
├── popup.html（彈出介面）
└── options.html（設定頁面）
```

**運作流程**:
```
1. Content Script偵測當前頁面平台
2. 啟用擴充圖示
3. 使用者點擊圖示
4. Popup顯示，讀取當前頁面留言
5. Background處理擷取
6. 顯示結果或下載
```

---

## 技術決策總結

1. **架構**: 平台適配器模式 ✅
2. **MVP**: FB + IG（4週）✅
3. **認證**: Token加密儲存 ✅
4. **後端**: Vercel Functions ✅
5. **V2**: Medium等平台 ✅
6. **V3**: Chrome擴充 ✅

---

**研究完成**: 2025-11-20  
**技術風險**: 已評估並有緩解方案

