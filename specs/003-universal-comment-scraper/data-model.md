# 資料模型：通用留言擷取工具

**日期**: 2025-11-20

## IndexedDB Schema

```typescript
class UniversalScraperDB extends Dexie {
  platforms!: Table<PlatformConfig>;
  credentials!: Table<EncryptedCredential>;
  comments!: Table<UnifiedComment>;
  scrapeTasks!: Table<ScrapeTask>;
  scrapeHistory!: Table<ScrapeHistory>;
  
  constructor() {
    super('UniversalScraperDB');
    this.version(1).stores({
      platforms: '++id, name, domain',
      credentials: '++id, platform, type',
      comments: '++id, platform, sourceUrl, timestamp, [platform+timestamp]',
      scrapeTasks: '++id, url, status, createdAt',
      scrapeHistory: '++id, timestamp, platform'
    });
  }
}
```

## 核心實體

### 1. PlatformConfig（平台配置）
```typescript
interface PlatformConfig {
  id?: number;
  name: 'facebook' | 'instagram' | 'medium' | 'vocus';
  displayName: string;
  authType: 'api' | 'login' | 'none';
  urlPatterns: RegExp[];
  scraperMode: 'api' | 'scrape' | 'hybrid';
}
```

### 2. UnifiedComment（統一留言結構）
```typescript
interface UnifiedComment {
  id?: number;
  platform: string;
  commentId: string;
  commenter: string;
  commenterUrl?: string;
  content: string;
  timestamp: Date;
  likes: number;
  replies?: number;
  sourceUrl: string;
  sourceTitle?: string;
  scrapedAt: Date;
  customFields: Record<string, any>;
}
```

### 3. ScrapeTask（擷取任務）
```typescript
interface ScrapeTask {
  id?: number;
  url: string;
  platform: string;
  status: 'pending' | 'running' | 'completed' | 'failed';
  progress: number;
  totalComments: number;
  createdAt: Date;
  completedAt?: Date;
  error?: string;
}
```

### 4. EncryptedCredential（加密憑證）
```typescript
interface EncryptedCredential {
  id?: number;
  platform: string;
  type: 'api' | 'login';
  encrypted: string;        // AES加密
  iv: string;               // 初始化向量
  expiresAt?: Date;
  lastVerified: Date;
  isValid: boolean;
}
```

---

**完成**: 2025-11-20

