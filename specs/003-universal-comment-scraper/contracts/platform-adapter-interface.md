# 平台適配器介面契約

**版本**: 1.0  
**日期**: 2025-11-20

## PlatformAdapter介面定義

```typescript
interface PlatformAdapter {
  // 平台資訊
  readonly name: string;
  readonly displayName: string;
  readonly authType: 'api' | 'login' | 'none';
  
  // 核心方法
  identify(url: string): boolean;
  authenticate(credentials: AuthCredentials): Promise<AuthResult>;
  scrape(url: string, options: ScrapeOptions): AsyncIterator<Comment>;
}
```

## 實作範例

### FacebookAdapter

```typescript
class FacebookAdapter implements PlatformAdapter {
  name = 'facebook';
  displayName = 'Facebook';
  authType = 'api';
  
  identify(url: string): boolean {
    return /facebook\.com/.test(url);
  }
  
  async authenticate(creds: AuthCredentials): Promise<AuthResult> {
    // 驗證Token
    const response = await fetch(
      `https://graph.facebook.com/me?access_token=${creds.token}`
    );
    return { success: !response.error };
  }
  
  async *scrape(url: string, options: ScrapeOptions) {
    // 解析postId
    const postId = this.parsePostId(url);
    
    // 呼叫API取得留言（分頁）
    let nextUrl = `/v18.0/${postId}/comments`;
    
    while (nextUrl) {
      const data = await this.api.get(nextUrl);
      
      for (const comment of data.data) {
        yield this.normalize(comment);
      }
      
      nextUrl = data.paging?.next;
    }
  }
}
```

---

**完成**: 2025-11-20

