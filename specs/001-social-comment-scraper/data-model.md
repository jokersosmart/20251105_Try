# 資料模型：社群留言爬蟲工具

**日期**: 2025-11-19  
**目的**: 定義 IndexedDB 資料庫 Schema、實體關聯和狀態轉換邏輯

---

## IndexedDB Schema 設計

### 資料庫配置

**資料庫名稱**: `SocialCommentScraperDB`  
**當前版本**: 1.0  
**使用工具**: Dexie.js

```typescript
import Dexie, { Table } from 'dexie';

export class ScraperDatabase extends Dexie {
  posts!: Table<Post>;
  comments!: Table<Comment>;
  scrapingStates!: Table<ScrapingState>;
  customFields!: Table<CustomField>;
  operationHistory!: Table<OperationHistory>;
  storageQuota!: Table<StorageQuotaStatus>;

  constructor() {
    super('SocialCommentScraperDB');
    
    this.version(1).stores({
      posts: '++id, url, platform, scrapedAt, [platform+createdAt]',
      comments: '++id, postId, commentId, timestamp, [postId+timestamp]',
      scrapingStates: '++id, postUrl, status, startedAt',
      customFields: '++id, postId, fieldName',
      operationHistory: '++id, timestamp, type',
      storageQuota: '++id, lastChecked'
    });
  }
}

export const db = new ScraperDatabase();
```

---

## 實體定義

### 1. Post（貼文）

**描述**: 代表一個 Instagram 或 Facebook 貼文

**屬性**:
```typescript
interface Post {
  id?: number;                    // IndexedDB 自動遞增 ID
  url: string;                    // 貼文完整網址（唯一識別）
  platform: 'instagram' | 'facebook';  // 平台類型
  postId: string;                 // 平台的貼文 ID（從網址解析）
  title?: string;                 // 貼文標題或前 100 字
  authorName?: string;            // 發文者名稱
  authorId?: string;              // 發文者 ID
  createdAt: Date;                // 發文時間（UTC）
  scrapedAt: Date;                // 爬取時間（本地時間）
  totalComments: number;          // 總留言數
  lastUpdatedAt?: Date;           // 最後更新時間（重新爬取）
}
```

**索引**:
- 主鍵：`++id`（自動遞增）
- 單一索引：`url`（快速查找）、`platform`、`scrapedAt`
- 複合索引：`[platform+createdAt]`（平台篩選+時間排序）

**使用場景**:
- 顯示已爬取的貼文列表
- 配額管理時按日期刪除舊貼文
- 批次爬取時避免重複

---

### 2. Comment（留言）

**描述**: 代表貼文下的單一留言

**屬性**:
```typescript
interface Comment {
  id?: number;                    // IndexedDB 自動遞增 ID
  postId: number;                 // 關聯到 Post.id（外鍵）
  commentId: string;              // 平台的留言 ID
  commenterName: string;          // 留言者名稱
  commenterAvatar?: string;       // 留言者頭像 URL
  commenterId?: string;           // 留言者 ID
  content: string;                // 留言內容（純文字）
  timestamp: Date;                // 留言時間（UTC，顯示時轉為本地時間）
  likeCount: number;              // 按讚數
  replyCount: number;             // 回覆數
  isEdited: boolean;              // 是否被使用者編輯過
  customFields: Record<string, string>;  // 自訂欄位（key-value 對）
  createdAt: Date;                // 儲存到 IndexedDB 的時間
}
```

**索引**:
- 主鍵：`++id`
- 單一索引：`postId`（依貼文查詢所有留言）、`commentId`、`timestamp`
- 複合索引：`[postId+timestamp]`（最常用查詢：特定貼文按時間排序）

**關聯**:
- 多對一：多個 Comment 屬於一個 Post
- 查詢範例：`db.comments.where('postId').equals(postId).sortBy('timestamp')`

**使用場景**:
- 顯示貼文的所有留言
- 按時間或按讚數排序
- 搜尋和篩選留言
- 編輯和刪除留言

---

### 3. ScrapingState（爬取狀態）

**描述**: 追蹤進行中或中斷的爬取任務，支援自動續傳

**屬性**:
```typescript
enum ScrapingStatus {
  IDLE = 'idle',
  RUNNING = 'running',
  PAUSED = 'paused',        // 網路中斷或使用者暫停
  COMPLETED = 'completed',
  FAILED = 'failed'
}

interface ScrapingState {
  id?: number;
  postUrl: string;                // 貼文網址
  postId: number;                 // 關聯到 Post.id
  status: ScrapingStatus;         // 當前狀態
  startedAt: Date;                // 開始時間
  lastUpdatedAt: Date;            // 最後更新時間
  currentProgress: number;        // 已擷取留言數量
  totalEstimated?: number;        // 預估總留言數（若 API 提供）
  lastSuccessCursor?: string;     // 最後成功的 API 分頁 cursor（用於續傳）
  errorMessage?: string;          // 錯誤訊息（若 status = failed）
  retryCount: number;             // 重試次數
}
```

**索引**:
- 主鍵：`++id`
- 單一索引：`postUrl`、`status`、`startedAt`

**狀態轉換圖**:
```
IDLE → RUNNING → COMPLETED
  ↓       ↓           
  ↓    PAUSED ⟷ RUNNING  (可恢復)
  ↓       ↓
  ↓    FAILED  (可重試)
  ↓
FAILED
```

**狀態轉換規則**:
- `IDLE → RUNNING`: 使用者點擊「開始爬取」
- `RUNNING → PAUSED`: 網路中斷、使用者手動暫停
- `PAUSED → RUNNING`: 使用者選擇「繼續爬取」
- `RUNNING → COMPLETED`: 所有留言爬取完成
- `RUNNING → FAILED`: API 錯誤、無效網址、超過重試次數
- `PAUSED → FAILED`: 使用者選擇「放棄並清除」
- `FAILED → RUNNING`: 使用者選擇「重新嘗試」

**使用場景**:
- 顯示爬取進度
- 網路恢復後提示續傳
- 批次爬取時追蹤每個任務

---

### 4. CustomField（自訂欄位定義）

**描述**: 使用者為特定貼文新增的自訂欄位配置

**屬性**:
```typescript
interface CustomField {
  id?: number;
  postId: number;                 // 關聯到 Post.id
  fieldName: string;              // 欄位名稱（例如：「客戶類型」）
  displayOrder: number;           // 顯示順序（從左到右）
  createdAt: Date;                // 建立時間
}
```

**索引**:
- 主鍵：`++id`
- 複合索引：`[postId+displayOrder]`（查詢特定貼文的欄位並排序）

**關聯**:
- 多對一：多個 CustomField 屬於一個 Post
- 一對多：一個 CustomField 對應 Comment.customFields 中的多個值

**使用場景**:
- 顯示表格時動態產生欄位
- 匯出 Excel 時包含自訂欄位
- 使用者新增/刪除/重新排序欄位

**資料儲存方式**:
- 欄位定義儲存在 `CustomField` table
- 實際值儲存在每個 `Comment.customFields`（key-value）
- 範例：
  ```typescript
  Comment {
    ...,
    customFields: {
      "客戶類型": "VIP",
      "回應狀態": "已處理"
    }
  }
  ```

---

### 5. OperationHistory（操作歷史）

**描述**: 記錄使用者的編輯操作，支援 Undo/Redo 功能

**屬性**:
```typescript
enum OperationType {
  EDIT = 'edit',         // 編輯儲存格
  DELETE = 'delete',     // 刪除留言
  ADD_FIELD = 'add_field',      // 新增欄位
  DELETE_FIELD = 'delete_field' // 刪除欄位
}

interface OperationHistory {
  id?: number;
  postId: number;                 // 關聯到 Post.id
  type: OperationType;            // 操作類型
  timestamp: Date;                // 操作時間
  affectedIds: number[];          // 受影響的 Comment IDs
  beforeState: any;               // 操作前的狀態（JSON）
  afterState: any;                // 操作後的狀態（JSON）
  description: string;            // 操作描述（例如：「編輯 3 則留言」）
}
```

**索引**:
- 主鍵：`++id`
- 單一索引：`postId`、`timestamp`
- 查詢：`db.operationHistory.where('postId').equals(id).reverse().limit(10)`

**儲存策略**:
- 僅保留最近 10 次操作（符合 FR-010）
- 超過 10 次時自動刪除最舊的
- 切換貼文時清空歷史

**Undo 實作邏輯**:
```typescript
async function undo() {
  // 取得最後一次操作
  const lastOp = await db.operationHistory
    .orderBy('timestamp')
    .last();
  
  if (!lastOp) return;
  
  // 恢復 beforeState
  await restoreState(lastOp.beforeState);
  
  // 刪除該操作記錄
  await db.operationHistory.delete(lastOp.id);
}
```

---

### 6. StorageQuotaStatus（儲存配額狀態）

**描述**: 追蹤 IndexedDB 使用量，觸發警告

**屬性**:
```typescript
interface StorageQuotaStatus {
  id?: number;                    // 固定為 1（singleton）
  usedBytes: number;              // 已使用空間（bytes）
  quotaBytes: number;             // 總配額（bytes）
  usagePercent: number;           // 使用百分比（0-100）
  lastChecked: Date;              // 最後檢查時間
  warningShown: boolean;          // 是否已顯示 80% 警告
  criticalShown: boolean;         // 是否已顯示 95% 警告
}
```

**索引**:
- 主鍵：`++id`
- 單一索引：`lastChecked`

**單例模式**:
- 整個資料庫僅有一筆記錄（id 固定為 1）
- 每次檢查配額時更新此記錄

**檢查頻率**:
- 應用程式啟動時檢查一次
- 每次爬取完成後檢查
- 每次編輯操作後檢查（節流：最多每分鐘一次）

**警告觸發**:
```typescript
async function checkQuota() {
  const quota = await navigator.storage.estimate();
  const percent = (quota.usage / quota.quota) * 100;
  
  await db.storageQuota.put({
    id: 1,
    usedBytes: quota.usage,
    quotaBytes: quota.quota,
    usagePercent: percent,
    lastChecked: new Date(),
    warningShown: percent >= 80,
    criticalShown: percent >= 95
  });
  
  if (percent >= 95) {
    showCriticalWarning(); // 阻擋新操作
  } else if (percent >= 80) {
    showWarning(); // 顯示警告橫幅
  }
}
```

---

## 實體關聯圖（ER Diagram）

```
┌─────────────┐
│    Post     │
│  (貼文)     │
└──────┬──────┘
       │ 1
       │
       │ N
┌──────┴──────────────┐
│     Comment         │
│    (留言)           │
│                     │
│ customFields: {}    │ ← 自訂欄位值
└─────────────────────┘

┌─────────────────────┐
│  ScrapingState      │
│  (爬取狀態)         │
│                     │
│  postId → Post      │
└─────────────────────┘

┌─────────────────────┐
│  CustomField        │
│  (欄位定義)         │
│                     │
│  postId → Post      │
└─────────────────────┘

┌─────────────────────┐
│ OperationHistory    │
│  (操作歷史)         │
│                     │
│  postId → Post      │
│  affectedIds → []   │
└─────────────────────┘

┌─────────────────────┐
│ StorageQuotaStatus  │
│  (配額狀態)         │
│  [Singleton]        │
└─────────────────────┘
```

**關聯說明**:
- Post ↔ Comment: 一對多（一個貼文有多個留言）
- Post ↔ ScrapingState: 一對一（每個貼文有一個爬取狀態）
- Post ↔ CustomField: 一對多（一個貼文可有多個自訂欄位）
- Post ↔ OperationHistory: 一對多（一個貼文有多個操作記錄）

---

## 資料生命週期

### 爬取流程的資料變化

```
1. 使用者輸入網址
   ↓
2. 創建 Post 記錄（status: IDLE）
   ↓
3. 創建 ScrapingState（status: RUNNING）
   ↓
4. 開始爬取，每 10 則留言：
   - 批次插入 Comment 記錄
   - 更新 ScrapingState.currentProgress
   ↓
5. 爬取完成：
   - 更新 ScrapingState（status: COMPLETED）
   - 更新 Post.totalComments
   ↓
6. 檢查配額
   - 更新 StorageQuotaStatus
   - 若 >80%，顯示警告
```

### 編輯流程的資料變化

```
1. 使用者編輯留言內容
   ↓
2. 創建 OperationHistory 記錄（保存 before/after）
   ↓
3. 更新 Comment 記錄
   - 修改 content
   - 設定 isEdited = true
   ↓
4. 自動儲存到 IndexedDB
   ↓
5. 檢查配額（節流：最多每分鐘一次）
```

### 清理流程的資料變化

```
1. 使用者開啟清理工具
   ↓
2. 查詢所有 Post（按 scrapedAt 排序）
   ↓
3. 使用者勾選要刪除的貼文
   ↓
4. 串聯刪除：
   - 刪除 Post
   - 刪除關聯的所有 Comment（cascade）
   - 刪除關聯的 ScrapingState
   - 刪除關聯的 CustomField
   - 刪除關聯的 OperationHistory
   ↓
5. 更新 StorageQuotaStatus
```

---

## 查詢模式與效能優化

### 常用查詢 1: 載入貼文的所有留言（按時間排序）

```typescript
const comments = await db.comments
  .where('[postId+timestamp]')
  .between([postId, Dexie.minKey], [postId, Dexie.maxKey])
  .toArray();
```

**效能**: O(log n) + O(k)，其中 k 是結果數量  
**優化**: 使用複合索引 `[postId+timestamp]` 避免全表掃描

### 常用查詢 2: 搜尋包含關鍵字的留言

```typescript
const results = await db.comments
  .where('postId').equals(postId)
  .filter(comment => comment.content.includes(keyword))
  .toArray();
```

**效能**: O(n)，其中 n 是該貼文的留言數  
**優化**: 先用索引篩選 postId，再在記憶體中過濾（比全表搜尋快）

### 常用查詢 3: 取得未完成的爬取任務

```typescript
const pausedTasks = await db.scrapingStates
  .where('status').equals('paused')
  .toArray();
```

**效能**: O(log n) + O(k)  
**優化**: `status` 欄位已建立索引

### 常用查詢 4: 配額管理 - 查詢最舊的貼文

```typescript
const oldestPosts = await db.posts
  .orderBy('scrapedAt')
  .limit(10)
  .toArray();
```

**效能**: O(log n) + O(10)  
**優化**: `scrapedAt` 欄位已建立索引

---

## 資料完整性與驗證

### 驗證規則

**Post 驗證**:
- `url` 必須是有效的 Instagram 或 Facebook 網址
- `platform` 與 `url` 格式必須匹配
- `totalComments` >= 0

**Comment 驗證**:
- `postId` 必須存在於 Post table
- `content` 不可為空字串
- `likeCount`, `replyCount` >= 0
- `timestamp` 必須是有效日期

**ScrapingState 驗證**:
- `status` 必須是有效的 ScrapingStatus
- `currentProgress` >= 0
- `retryCount` <= 3（超過 3 次標記為 FAILED）

### 參照完整性（Referential Integrity）

**串聯刪除**（Cascade Delete）:
```typescript
async function deletePost(postId: number) {
  await db.transaction('rw', 
    db.posts, 
    db.comments, 
    db.scrapingStates,
    db.customFields,
    db.operationHistory,
    async () => {
      // 刪除貼文
      await db.posts.delete(postId);
      
      // 串聯刪除所有關聯資料
      await db.comments.where('postId').equals(postId).delete();
      await db.scrapingStates.where('postId').equals(postId).delete();
      await db.customFields.where('postId').equals(postId).delete();
      await db.operationHistory.where('postId').equals(postId).delete();
    }
  );
}
```

---

## 資料遷移策略

### 版本 1.0 → 1.1（範例）

假設未來需要新增欄位：

```typescript
this.version(1.1).stores({
  // Schema 保持不變
}).upgrade(trans => {
  // 為所有現有留言新增 isHidden 欄位
  return trans.comments.toCollection().modify(comment => {
    comment.isHidden = false;
  });
});
```

**Dexie.js 自動處理**:
- 使用者開啟應用程式時自動升級
- 保留所有現有資料
- 執行 upgrade 函式

---

## 效能考量

### 批次操作優化

**批次插入留言**（爬取時）:
```typescript
// ❌ 錯誤：逐一插入（慢）
for (const comment of comments) {
  await db.comments.add(comment);
}

// ✅ 正確：批次插入（快 10 倍）
await db.comments.bulkAdd(comments);
```

### 查詢結果快取

**記憶體快取熱門查詢**:
```typescript
const cache = new Map();

async function getComments(postId: number) {
  const cacheKey = `comments_${postId}`;
  
  if (cache.has(cacheKey)) {
    return cache.get(cacheKey);
  }
  
  const comments = await db.comments
    .where('postId').equals(postId)
    .toArray();
  
  cache.set(cacheKey, comments);
  return comments;
}

// 編輯時清除快取
function invalidateCache(postId: number) {
  cache.delete(`comments_${postId}`);
}
```

### 索引最佳化

**複合索引設計原則**:
- 最常組合查詢的欄位建立複合索引
- 排序欄位放在索引最後
- 範例：`[postId+timestamp]` 支援「查詢特定貼文並按時間排序」

---

## 資料大小估算

### 單一留言大小

```
Comment 記錄 ~500 bytes:
- commenterName: 20 bytes
- content: 200 bytes（平均）
- timestamp: 8 bytes
- 其他欄位: ~100 bytes
- 自訂欄位: ~100 bytes（2-3 個欄位）
- IndexedDB overhead: ~70 bytes
```

### 儲存容量估算

| 留言數量 | 預估大小 | 配額百分比（假設 5GB 配額） |
|---------|---------|---------------------------|
| 1,000 | ~500 KB | <0.01% |
| 10,000 | ~5 MB | 0.1% |
| 100,000 | ~50 MB | 1% |
| 1,000,000 | ~500 MB | 10% |

**結論**: 
- 一般使用者（50 個貼文，每貼文 500 則）: ~12.5 MB（0.25%）
- 重度使用者（200 個貼文）: ~50 MB（1%）
- 80% 警告觸發於 ~4GB（約 800 萬則留言）
- **實際限制遠低於配額**，主要受瀏覽器效能影響

---

## TypeScript 類型定義

完整的 TypeScript interfaces 將定義在 `frontend/src/types/` 目錄：

```
frontend/src/types/
├── comment.ts          # Comment interface
├── post.ts             # Post interface
├── scraping-state.ts   # ScrapingState, ScrapingStatus
├── custom-field.ts     # CustomField interface
├── operation.ts        # OperationHistory, OperationType
├── quota.ts            # StorageQuotaStatus interface
└── index.ts            # 統一匯出
```

---

## 測試資料準備

### Mock 資料範例

**測試用 Post**:
```typescript
const mockPost: Post = {
  id: 1,
  url: 'https://www.instagram.com/p/ABC123/',
  platform: 'instagram',
  postId: 'ABC123',
  title: '測試貼文標題',
  authorName: 'test_user',
  createdAt: new Date('2025-11-01'),
  scrapedAt: new Date('2025-11-19'),
  totalComments: 150
};
```

**測試用 Comment**:
```typescript
const mockComment: Comment = {
  id: 1,
  postId: 1,
  commentId: 'comment_001',
  commenterName: '測試使用者',
  content: '這是一則測試留言 👍',
  timestamp: new Date('2025-11-18T10:30:00Z'),
  likeCount: 5,
  replyCount: 2,
  isEdited: false,
  customFields: {},
  createdAt: new Date()
};
```

---

## 下一步

- ✅ 資料模型已完整定義
- ⏭️ 實作 Dexie.js Schema（tasks.md 中的任務）
- ⏭️ 建立 TypeScript 類型定義檔案
- ⏭️ 撰寫資料存取層（Data Access Layer）測試

---

**文件完成時間**: 2025-11-19  
**下一個文件**: contracts/（API 契約定義）

