# Meta API 申請完整指南（Instagram + Facebook）

**版本**: 1.0  
**更新日期**: 2025-11-19  
**預計完成時間**: 2-3 小時（不含審核等待）  
**審核等待時間**: 3-5 個工作天

---

## 📋 目錄

1. [前置準備](#前置準備)
2. [步驟 1: 註冊開發者帳號](#步驟-1-註冊開發者帳號)
3. [步驟 2: 建立應用程式](#步驟-2-建立應用程式)
4. [步驟 3: 配置應用程式設定](#步驟-3-配置應用程式設定)
5. [步驟 4: 新增 Instagram 產品](#步驟-4-新增-instagram-產品)
6. [步驟 5: 新增 Facebook 產品](#步驟-5-新增-facebook-產品)
7. [步驟 6: 取得 App Access Token](#步驟-6-取得-app-access-token)
8. [步驟 7: 申請進階權限](#步驟-7-申請進階權限)
9. [步驟 8: 準備審核文件](#步驟-8-準備審核文件)
10. [步驟 9: 提交審核](#步驟-9-提交審核)
11. [步驟 10: 審核期間的開發](#步驟-10-審核期間的開發)
12. [常見問題](#常見問題)

---

## 🎯 前置準備

### 必要條件

- [ ] Facebook 個人帳號（必須）
- [ ] 有效的電子郵件地址
- [ ] 手機號碼（用於驗證）
- [ ] 網站或 GitHub Pages（用於託管隱私政策）

### 需要準備的資料

- [ ] **應用程式名稱**: 社群留言爬蟲工具（或您偏好的名稱）
- [ ] **聯絡電子郵件**: [您的 email]
- [ ] **應用程式用途說明**: 稍後詳細說明
- [ ] **隱私政策 URL**: 稍後建立
- [ ] **使用條款 URL**: 稍後建立

### 預估時間分配

| 步驟 | 時間 | 可否同時進行 |
|------|------|-------------|
| 註冊開發者 | 10 分鐘 | - |
| 建立應用程式 | 15 分鐘 | - |
| 新增產品 | 10 分鐘 | - |
| 取得 Token | 10 分鐘 | - |
| 準備審核文件 | 60 分鐘 | ✅ 可先準備 |
| 申請權限 | 30 分鐘 | - |
| **總計** | **2-3 小時** | |

---

## 步驟 1: 註冊開發者帳號

### 1.1 前往 Meta for Developers

**網址**: https://developers.facebook.com/

**看到的畫面**:
- 上方導航列：產品、文件、支援
- 中間：「開始使用」或「登入」按鈕
- 下方：功能介紹

---

### 1.2 使用 Facebook 帳號登入

**步驟**:
1. 點擊右上角「**登入**」按鈕
2. 使用您的 Facebook 帳號登入
   - 輸入 Facebook 帳號和密碼
   - 如有雙重驗證，完成驗證步驟

**⚠️ 注意**: 
- 必須使用真實 Facebook 帳號
- 建議使用商業或專業帳號（非個人私密帳號）
- 帳號需要已驗證（有電子郵件或手機驗證）

---

### 1.3 接受開發者條款

**首次登入會看到**:
- 標題：「歡迎使用 Meta for Developers」
- 內容：開發者條款和政策

**需要做的**:
1. ✅ 勾選「我已閱讀並同意 Meta Platform Terms 和 Developer Policies」
2. 點擊「**接受**」或「**同意並繼續**」

---

### 1.4 完成開發者註冊表單

**需要填寫的資訊**:

| 欄位 | 填寫範例 | 說明 |
|------|---------|------|
| **全名** | 王小明 | 您的真實姓名 |
| **電子郵件** | your.email@example.com | 接收通知用 |
| **國家/地區** | Taiwan | 選擇「台灣」|
| **電話號碼** | +886-9XX-XXX-XXX | 用於驗證和安全 |
| **您的角色** | Developer（開發者）| 或 Business Owner |
| **公司名稱**（選填）| [您的公司] 或留空 | 個人開發者可留空 |

**完成後**: 點擊「**繼續**」或「**完成註冊**」

---

### 1.5 驗證電子郵件

**會發生什麼**:
- Meta 發送驗證郵件到您的 email
- 郵件主旨：「Confirm your email for Meta for Developers」

**步驟**:
1. 打開您的電子郵件
2. 找到 Meta 的驗證郵件
3. 點擊郵件中的「**驗證電子郵件**」或「**Confirm Email**」連結
4. 瀏覽器會開啟並顯示「電子郵件已驗證」

---

### 1.6 完成雙重驗證（建議，但非必須）

**為什麼要做**: 
- 某些進階功能需要驗證
- 提高帳號安全性
- 審核通過率較高

**步驟**:
1. 在開發者主控台，前往「設定」→「安全性」
2. 啟用「雙重驗證」
3. 選擇方式：
   - **簡訊驗證碼**（推薦）
   - Authenticator App（Google Authenticator）
4. 按照指示完成設定

---

### ✅ 步驟 1 完成檢查

完成後，您應該能夠：
- [x] 成功登入 Meta for Developers
- [x] 看到開發者主控台
- [x] 在右上角看到您的名稱和頭像
- [x] 電子郵件已驗證（信箱圖示旁有✓）

**預計時間**: 10-15 分鐘

---

## 步驟 2: 建立應用程式

### 2.1 進入「我的應用程式」

**步驟**:
1. 在 Meta for Developers 主控台
2. 點擊上方導航列的「**我的應用程式**」（My Apps）
3. 如果是第一次，會看到空白頁面和「建立應用程式」按鈕

---

### 2.2 點擊「建立應用程式」

**步驟**:
1. 點擊「**建立應用程式**」（Create App）按鈕
2. 會彈出「選擇應用程式類型」對話框

---

### 2.3 選擇應用程式類型

**看到的選項**:
- 🎮 **遊戲**
- 💼 **商業** ← **選擇這個**
- 👤 **消費者**
- 🔧 **其他** ← 或選擇這個

**建議選擇**: **「商業」** 或 **「其他」**

**理由**: 
- 本工具用於商業分析（客戶留言收集）
- 「商業」類型適合企業使用場景
- 「其他」也可以，較寬鬆

**選擇後**: 點擊「**下一步**」（Next）

---

### 2.4 填寫應用程式詳細資訊

**表單欄位**:

#### 基本資訊

| 欄位 | 填寫內容 | 範例 |
|------|---------|------|
| **應用程式名稱*** | 社群留言爬蟲工具 | Social Comment Scraper |
| **應用程式顯示名稱*** | 社群留言爬蟲工具 | 同上 |
| **應用程式聯絡電子郵件*** | your.email@example.com | 必須是有效 email |
| **商業帳號**（可選）| [留空] 或選擇您的商業帳號 | 個人開發者可留空 |

**\* = 必填欄位**

#### 進階選項（展開「顯示進階選項」）

| 欄位 | 填寫內容 | 說明 |
|------|---------|------|
| **應用程式用途** | Data analysis for customer engagement | 簡短說明 |
| **App Category** | Business Tools | 選擇適合的類別 |

---

### 2.5 完成建立

**步驟**:
1. 確認所有必填欄位已填寫
2. 點擊「**建立應用程式**」（Create App）
3. 可能需要完成安全性驗證（CAPTCHA）
4. 完成後會進入應用程式控制面板

**成功的標誌**:
- ✅ 看到應用程式控制面板
- ✅ 左側顯示應用程式名稱
- ✅ 中間顯示「新增產品」選項

---

### 2.6 記錄 App ID 和 App Secret

**立即記錄這些資訊！**

**步驟**:
1. 在應用程式控制面板
2. 左側選單：「**設定**」（Settings） → 「**基本**」（Basic）
3. 您會看到：

| 資訊 | 位置 | 說明 |
|------|------|------|
| **應用程式編號** | 頁面上方 | 例如：123456789012345 |
| **應用程式密鑰** | 需點擊「顯示」 | 例如：abcdef1234567890... |

**重要步驟**:
```
1. 複製「應用程式編號」（App ID）
   儲存到安全的地方（例如：密碼管理器）
   
2. 點擊「應用程式密鑰」旁的「顯示」按鈕
   - 可能需要重新輸入 Facebook 密碼
   - 複製顯示的密鑰
   - 儲存到安全的地方
   
3. ⚠️ 千萬不要：
   - 公開分享這些資訊
   - Commit 到 Git
   - 貼在公開論壇
```

**儲存格式**（本地筆記）:
```
專案：社群留言爬蟲工具
App ID: 123456789012345
App Secret: abcdef1234567890abcdef1234567890
建立日期：2025-11-19
```

---

### ✅ 步驟 2 完成檢查

- [x] 應用程式已建立
- [x] App ID 已記錄
- [x] App Secret 已記錄
- [x] 應用程式狀態：Development（開發模式）

**預計時間**: 15 分鐘

---

## 步驟 3: 配置應用程式設定

### 3.1 設定應用程式網域

**位置**: 「設定」→「基本」

**需要設定的欄位**:

| 欄位 | 填寫內容 | 範例 |
|------|---------|------|
| **應用程式網域** | localhost, your-app.vercel.app | 開發和生產域名 |
| **隱私政策網址*** | https://yourusername.github.io/privacy.html | 必須是 HTTPS |
| **使用條款網址** | https://yourusername.github.io/terms.html | 建議提供 |
| **使用者資料刪除指示** | 請聯繫 your.email@example.com | 或提供 URL |

**\* = 必填欄位**

**詳細說明**:

#### 應用程式網域
```
localhost
your-app-name.vercel.app
```
**說明**: 允許這些域名呼叫 API，每行一個域名

#### 隱私政策網址
**必須提供！** 否則無法申請權限

**快速建立方法**（使用 GitHub Pages）:
```
1. 在 GitHub 建立新 repository：app-policies
2. 建立 privacy.html（使用開發環境準備指南.md 中的範本）
3. 啟用 GitHub Pages：Settings → Pages → Source: main branch
4. 取得 URL：https://yourusername.github.io/app-policies/privacy.html
5. 填入 Meta 設定中
```

**隱私政策必須包含的內容**:
- ✅ 收集哪些資料（留言、使用者名稱、時間）
- ✅ 如何使用資料（顯示、分析、匯出）
- ✅ 如何儲存資料（瀏覽器本地，不傳送伺服器）
- ✅ 如何刪除資料（使用者可隨時刪除）
- ✅ 聯絡方式（email）

---

### 3.2 設定平台

**位置**: 同樣在「設定」→「基本」，往下滾動

**步驟**:
1. 找到「**新增平台**」（Add Platform）按鈕
2. 選擇「**網站**」（Website）
3. 填寫：

| 欄位 | 填寫內容 |
|------|---------|
| **網站 URL** | https://your-app.vercel.app |
| **行動網站 URL** | （留空或同上）|

**說明**: 
- 開發階段可填 `http://localhost:5173`
- 生產環境填 Vercel 部署 URL
- 可之後再更新

---

### 3.3 儲存變更

**重要**: 
1. 滾動到頁面最下方
2. 點擊「**儲存變更**」（Save Changes）按鈕
3. 等待「已儲存」提示

**⚠️ 常見錯誤**: 忘記點擊儲存！務必確認已儲存。

---

### ✅ 步驟 3 完成檢查

- [x] 應用程式網域已設定
- [x] 隱私政策 URL 已填寫
- [x] 平台（網站）已新增
- [x] 變更已儲存

---

## 步驟 4: 新增 Instagram 產品

### 4.1 前往「新增產品」

**步驟**:
1. 在應用程式控制面板
2. 左側選單找到「**新增產品**」（Add Products）
3. 或中間看到「**新增產品**」卡片

---

### 4.2 選擇 Instagram 產品

**看到的產品列表**:
- Facebook Login
- **Instagram** ← 找到這個
- Messenger
- WhatsApp
- 等等...

**步驟**:
1. 找到「**Instagram**」卡片
2. 底下有兩個選項：
   - **Instagram Basic Display** ← 選擇這個
   - Instagram Graph API（需要更高權限）

3. 點擊 Instagram Basic Display 下的「**設定**」（Set Up）按鈕

---

### 4.3 Instagram Basic Display 快速入門

**會看到快速入門頁面**，有 4 個步驟：

#### 步驟 1: 建立 Instagram 應用程式

點擊「**建立新的應用程式**」（Create New App）

**需要填寫**:

| 欄位 | 填寫內容 | 範例 |
|------|---------|------|
| **顯示名稱** | 社群留言爬蟲工具 | Social Comment Scraper |
| **有效的 OAuth 重新導向 URI** | https://your-app.vercel.app/auth/callback | 或 http://localhost:5173/auth/callback |
| **停用帳號網址** | https://your-app.vercel.app/deauthorize | 或留空 |
| **資料刪除要求網址** | https://your-app.vercel.app/data-deletion | 或留空 |

**說明**:
- OAuth URI: 如果不需要使用者登入，填 localhost 即可
- 後兩個 URL: 可以稍後補充，或提供 email 替代

點擊「**儲存變更**」

#### 步驟 2-4: 可以跳過

**原因**: 我們使用 App Access Token，不需要 User Access Token

直接關閉此頁面，回到應用程式控制面板

---

### 4.4 確認 Instagram 產品已新增

**驗證**:
1. 回到控制面板
2. 左側選單應該出現「**Instagram Basic Display**」
3. 點進去可以看到設定

---

### ✅ 步驟 4 完成檢查

- [x] Instagram Basic Display 產品已新增
- [x] OAuth 設定已完成（或跳過）
- [x] 左側選單可見 Instagram 選項

**預計時間**: 5-8 分鐘

---

## 步驟 5: 新增 Facebook 產品

### 5.1 再次前往「新增產品」

**步驟**:
1. 左側選單「**新增產品**」
2. 或滾動中間面板找到其他產品

---

### 5.2 新增 Facebook Login

**步驟**:
1. 找到「**Facebook Login**」卡片
2. 點擊「**設定**」（Set Up）

---

### 5.3 選擇平台

**會詢問**: 「您的應用程式在哪個平台上執行？」

**選擇**: 「**網站**」（Web）

**點擊**: 「**下一步**」

---

### 5.4 設定網站 URL

**需要填寫**:

| 欄位 | 填寫內容 |
|------|---------|
| **網站 URL** | https://your-app.vercel.app |

**或開發階段**:
```
http://localhost:5173
```

點擊「**儲存**」並「**繼續**」

---

### 5.5 完成 Facebook Login 設定

**快速入門的其他步驟可以跳過**:
- 步驟 2-6: SDK 安裝、登入按鈕等
- **原因**: 我們不需要使用者登入

直接關閉或點擊左上角返回控制面板

---

### 5.6 配置 Facebook Login 設定

**重要步驟**:

1. 左側選單：「**Facebook Login**」→「**設定**」
2. 找到「**有效的 OAuth 重新導向 URI**」
3. 填寫：
   ```
   http://localhost:5173/auth/callback
   https://your-app.vercel.app/auth/callback
   ```
4. 滾動到底部點擊「**儲存變更**」

---

### ✅ 步驟 5 完成檢查

- [x] Facebook Login 產品已新增
- [x] 網站平台已設定
- [x] OAuth URI 已設定
- [x] 左側選單可見 Facebook Login

**預計時間**: 5-8 分鐘

---

## 步驟 6: 取得 App Access Token

這是**最關鍵**的步驟！此 Token 將用於所有 API 呼叫。

### 方法 1: 使用 Graph API Explorer（推薦）⭐

#### 6.1 前往 Graph API Explorer

**網址**: https://developers.facebook.com/tools/explorer/

**或從控制面板**:
1. 上方導航列：「**工具**」（Tools）
2. 選擇「**Graph API Explorer**」

---

#### 6.2 選擇您的應用程式

**步驟**:
1. 右上角找到「**Meta App**」下拉選單
2. 預設可能顯示「Graph API Explorer」
3. 點擊下拉選單
4. 找到並選擇您剛建立的應用程式：「**社群留言爬蟲工具**」

---

#### 6.3 取得 App Token

**關鍵步驟**:

1. 在「**User or Page**」下拉選單
2. 預設顯示「Get Token」或您的使用者名稱
3. 點擊下拉選單
4. 選擇「**Get App Token**」← 這個很重要！
5. 可能會彈出確認對話框，點擊「**確定**」

**成功後**:
- 「Access Token」欄位會顯示一長串 Token
- 格式類似：`123456789012345|AbCdEfGhIjKlMnOpQrStUvWxYz`
- 或純數字加字母的長字串

---

#### 6.4 複製和儲存 Token

**步驟**:
1. **選取整個 Token**（可能很長，確認全選）
2. **複製**（Ctrl+C）
3. **立即儲存到安全的地方**：

**儲存位置建議**:
```
檔案：API-Tokens.txt（本地，不要 commit）

Instagram/Facebook App Access Token:
123456789012345|AbCdEfGhIjKlMnOpQrStUvWxYz

建立日期：2025-11-19
App ID: 123456789012345
永久有效（除非重設 App Secret）
```

---

#### 6.5 測試 Token

**立即測試 Token 是否有效**:

```bash
# 替換 YOUR_TOKEN
curl "https://graph.facebook.com/v18.0/me?access_token=YOUR_TOKEN"

# 預期回應（App Token）:
{
  "id": "123456789012345",  # 您的 App ID
  "name": "社群留言爬蟲工具"   # 您的 App 名稱
}

# 如果看到這個回應，Token 有效！✅
```

---

### 方法 2: 使用 API 請求取得（替代方法）

**如果 Graph API Explorer 無法使用**:

```bash
# 使用您在步驟 2.6 記錄的 App ID 和 App Secret

curl -X GET "https://graph.facebook.com/oauth/access_token?client_id=YOUR_APP_ID&client_secret=YOUR_APP_SECRET&grant_type=client_credentials"

# 回應:
{
  "access_token": "123456789012345|AbCdEf...",
  "token_type": "bearer"
}

# 複製 access_token 的值
```

---

### 6.6 Token 類型說明

**App Access Token vs User Access Token**:

| 類型 | 格式 | 用途 | 權限 |
|------|------|------|------|
| **App Access Token** ✅ | `{app-id}\|{hash}` | 應用程式層級，我們使用這個 | 公開資料 |
| User Access Token | 純字串 | 使用者層級 | 使用者授權的資料 |

**我們需要的**: **App Access Token** ✅

**特點**:
- ✅ 永久有效（直到重設 App Secret）
- ✅ 使用者無需登入授權
- ✅ 只能存取公開資料
- ⚠️ 所有使用者共用配額

---

### ✅ 步驟 6 完成檢查

- [x] App Access Token 已取得
- [x] Token 已測試有效
- [x] Token 已安全儲存
- [x] Token 格式正確（包含 `|` 符號）

**預計時間**: 10 分鐘

---

## 步驟 7: 申請進階權限

### 7.1 了解權限需求

**我們的專案需要的權限**:

#### Instagram 權限
- `instagram_basic` - 基本顯示（讀取公開貼文）
- `instagram_manage_comments` - 留言管理（讀取留言）

#### Facebook 權限
- `pages_read_engagement` - 讀取粉專互動（留言、按讚數）
- 或 `public_profile` + `user_posts`（如果爬取個人貼文）

---

### 7.2 前往「應用程式審查」

**步驟**:
1. 左側選單
2. 找到「**應用程式審查**」（App Review）
3. 點擊「**權限和功能**」（Permissions and Features）

---

### 7.3 搜尋並申請 Instagram 權限

**步驟**:

1. **在搜尋框輸入**: `instagram_basic`
2. 找到「**instagram_basic**」權限
3. 點擊右側的「**申請**」（Request）按鈕
4. 重複搜尋「**instagram_manage_comments**」並申請

---

### 7.4 搜尋並申請 Facebook 權限

**步驟**:

1. 搜尋框輸入：`pages_read_engagement`
2. 找到權限
3. 點擊「**申請**」

---

### 7.5 填寫權限申請表單

**每個權限都需要填寫申請表單！**

#### 表單結構

**會看到的欄位**:

1. **此權限的用途**（Tell us how you'll use this permission）
2. **詳細使用說明**（Detailed Description）
3. **截圖或影片**（可選）
4. **隱私政策 URL**（已在步驟 3 填寫，會自動帶入）

---

#### 範例：instagram_basic 權限申請

**欄位 1: 此權限的用途**（簡短，1-2 句話）

```
我們的應用程式協助企業操作人員收集 Instagram 公開貼文的留言資料，用於客戶意見分析和商業洞察。使用者輸入貼文網址，系統透過 API 擷取公開留言並提供編輯和匯出功能。
```

**英文版本**（如果需要）:
```
Our application helps business operators collect comment data from public Instagram posts for customer feedback analysis and business insights. Users input post URLs, and the system retrieves public comments via API, providing editing and export features.
```

---

**欄位 2: 詳細使用說明**（詳細，說明使用流程）

```markdown
## 應用程式概述

本工具名為「社群留言爬蟲工具」，專為不具備技術背景的商業操作人員設計，協助他們快速收集和分析社群媒體上的客戶留言。

## 使用流程

1. **輸入階段**
   - 使用者在網頁介面輸入 Instagram 公開貼文的完整網址
   - 系統驗證網址格式是否正確
   - 確認貼文為公開狀態

2. **爬取階段**（使用 instagram_basic 權限）
   - 系統透過 Instagram Graph API 呼叫 `/{media-id}/comments` 端點
   - 取得公開留言資料，包括：
     * 留言 ID
     * 留言者公開使用者名稱
     * 留言內容
     * 留言時間戳記
     * 按讚數（公開資料）
   - 顯示即時進度（已擷取 X 則留言）
   - 資料儲存在使用者瀏覽器本地（IndexedDB），不傳送到我們的伺服器

3. **編輯階段**
   - 使用者可在線上表格中編輯留言資料
   - 新增自訂分類欄位（例如：客戶類型、回應狀態）
   - 搜尋和篩選特定留言

4. **匯出階段**
   - 使用者可將資料匯出為 Excel 檔案
   - 用於後續商業分析、客服追蹤、報表製作

## 為何需要此權限

- **instagram_basic**: 讀取公開貼文的基本資訊和留言資料
- 我們**不會**：
  - 存取私人帳號或非公開內容
  - 發布或修改任何內容
  - 存取使用者個人資訊（僅讀取公開顯示的使用者名稱）
  - 將資料儲存到我們的伺服器（全部儲存在使用者瀏覽器本地）

## 資料隱私保護

- 所有資料儲存在使用者瀏覽器本地（IndexedDB）
- 不傳送到遠端伺服器
- 使用者可隨時刪除所有資料
- 完整隱私政策：[您的隱私政策 URL]

## 目標使用者

- 行銷人員：分析社群媒體反饋
- 客服人員：追蹤客戶留言和回應
- 社群管理者：監測品牌提及和互動

## 使用頻率

- 預期每位使用者每天爬取 5-10 個貼文
- 每個貼文平均 100-500 則留言
- 總 API 呼叫：每天約 50-100 次（遠低於速率限制）
```

---

#### 範例：instagram_manage_comments 權限申請

**欄位 1: 此權限的用途**

```
此權限用於讀取 Instagram 公開貼文的完整留言資料，包括留言內容、留言者資訊、互動數據（按讚數、回覆數）。這些資料將顯示在我們的分析工具中，協助使用者進行客戶意見分析。
```

**欄位 2: 詳細使用說明**

```markdown
## 權限用途

`instagram_manage_comments` 權限讓我們能夠：
- 讀取公開貼文的所有留言
- 取得留言的詳細資訊（內容、時間、互動數據）
- 取得回覆數量

## API 呼叫方式

- 端點：`GET /{media-id}/comments`
- 欄位：`id,username,text,timestamp,like_count,replies`
- 僅讀取，不修改或刪除留言
- 僅存取完全公開的留言

## 為何需要此權限

相較於 `instagram_basic`，此權限提供：
- 更完整的留言資料
- 回覆數量統計
- 更好的互動數據（用於分析熱門留言）

## 資料處理

- 留言資料僅用於顯示和分析
- 不會發布、修改或刪除任何留言
- 不會代表使用者執行任何操作

（其餘說明同 instagram_basic）
```

---

#### 範例：pages_read_engagement 權限申請

**欄位 1: 此權限的用途**

```
此權限用於讀取 Facebook 粉絲專頁公開貼文的留言和互動資料。使用者可分析粉專貼文的客戶留言，追蹤客戶回饋和互動趨勢。
```

**欄位 2: 詳細使用說明**

```markdown
## 權限用途

`pages_read_engagement` 權限讓我們能夠：
- 讀取粉絲專頁公開貼文的留言
- 取得留言者公開資訊（姓名、ID）
- 取得互動數據（按讚數、留言數）

## API 呼叫方式

- 端點：`GET /{post-id}/comments`
- 欄位：`id,from{name,id},message,created_time,like_count,comment_count`
- 僅讀取公開貼文，不存取私人內容

## 使用場景

1. 企業監測自家粉專的客戶留言
2. 分析競品粉專的公開互動（僅公開貼文）
3. 追蹤產品發布後的客戶反饋

## 資料處理

- 僅讀取公開可見的留言資料
- 不會發布內容或修改粉專設定
- 資料儲存在使用者瀏覽器本地
- 符合 Facebook 平台政策和台灣個資法

（其餘說明同上）
```

---

### 7.6 提交申請

**每個權限填寫完成後**:

1. 檢查所有欄位已填寫
2. 確認隱私政策 URL 正確
3. 點擊「**提交**」（Submit）或「**送出以供審查**」
4. 會看到狀態變更為「**審查中**」（In Review）

---

### 7.7 申請所有需要的權限

**重複步驟 7.3-7.6**，依序申請：
- [ ] instagram_basic
- [ ] instagram_manage_comments  
- [ ] pages_read_engagement

**每個權限都要單獨申請！**

---

### ✅ 步驟 7 完成檢查

- [x] instagram_basic 已申請
- [x] instagram_manage_comments 已申請
- [x] pages_read_engagement 已申請
- [x] 所有權限狀態：「審查中」
- [x] 申請表單已完整填寫

**預計時間**: 30-45 分鐘

---

## 步驟 8: 準備審核文件

### 8.1 隱私政策詳細版本

**完整範本**（可直接使用）:

```html
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>隱私權政策 - 社群留言爬蟲工具</title>
    <style>
        body {
            font-family: Arial, "Microsoft JhengHei", sans-serif;
            max-width: 800px;
            margin: 40px auto;
            padding: 20px;
            line-height: 1.6;
        }
        h1 { color: #2c3e50; }
        h2 { color: #34495e; margin-top: 30px; }
        ul { margin: 10px 0; }
        .updated { color: #7f8c8d; font-size: 14px; }
    </style>
</head>
<body>
    <h1>隱私權政策</h1>
    <p class="updated">最後更新：2025 年 11 月 19 日</p>

    <h2>1. 服務說明</h2>
    <p>
        「社群留言爬蟲工具」（以下簡稱「本服務」）是一個線上工具，
        協助企業和個人使用者收集 Instagram 和 Facebook 公開貼文的留言資料，
        用於合法的商業分析、客戶意見研究和社群媒體監測。
    </p>

    <h2>2. 資料收集</h2>
    <p>本服務透過 Meta（Facebook）官方 API 收集以下<strong>公開資料</strong>：</p>
    <ul>
        <li><strong>留言內容</strong>：使用者在公開貼文下的留言文字</li>
        <li><strong>留言者資訊</strong>：公開顯示的使用者名稱或帳號名稱</li>
        <li><strong>留言時間</strong>：留言發布的時間戳記</li>
        <li><strong>互動數據</strong>：公開的按讚數和回覆數</li>
    </ul>
    
    <p><strong>我們不會收集</strong>：</p>
    <ul>
        <li>私人或受限制的貼文和留言</li>
        <li>使用者的個人聯絡資訊（電話、地址、email）</li>
        <li>使用者的私人訊息或 DM</li>
        <li>使用者的密碼或登入憑證</li>
        <li>使用者的朋友列表或社交圖譜</li>
    </ul>

    <h2>3. 資料使用目的</h2>
    <p>收集的資料僅用於：</p>
    <ul>
        <li><strong>顯示</strong>：在本服務的網頁介面中展示給使用者</li>
        <li><strong>編輯</strong>：使用者可在線上表格中編輯和分類</li>
        <li><strong>匯出</strong>：匯出為 Excel 檔案供使用者下載</li>
        <li><strong>分析</strong>：使用者自行進行商業分析（我們不進行分析）</li>
    </ul>

    <p><strong>我們不會</strong>：</p>
    <ul>
        <li>將資料用於廣告或行銷目的</li>
        <li>將資料出售或分享給第三方</li>
        <li>將資料用於訓練 AI 模型</li>
        <li>追蹤使用者行為用於其他目的</li>
    </ul>

    <h2>4. 資料儲存</h2>
    <p><strong>本地儲存</strong>（重要！）：</p>
    <ul>
        <li>所有留言資料儲存在<strong>使用者自己的瀏覽器</strong>中（IndexedDB）</li>
        <li>我們的伺服器<strong>不會儲存</strong>任何留言資料</li>
        <li>後端僅作為 API 代理，不記錄或保存請求內容</li>
    </ul>

    <p><strong>儲存期限</strong>：</p>
    <ul>
        <li>資料保留在使用者瀏覽器中，預設 30 天</li>
        <li>使用者可隨時手動刪除所有資料</li>
        <li>清除瀏覽器資料會自動刪除所有爬取的留言</li>
    </ul>

    <h2>5. 資料安全</h2>
    <p>我們採取以下措施保護資料：</p>
    <ul>
        <li><strong>HTTPS 加密</strong>：所有資料傳輸使用 SSL/TLS 加密</li>
        <li><strong>本地儲存</strong>：資料不離開使用者裝置</li>
        <li><strong>API Token 保護</strong>：使用安全的後端代理保護 API 金鑰</li>
        <li><strong>無中央資料庫</strong>：我們不維護任何留言資料的中央資料庫</li>
    </ul>

    <h2>6. 使用者權利</h2>
    <p>使用者擁有以下權利：</p>
    <ul>
        <li><strong>存取權</strong>：可隨時查看所有已收集的資料</li>
        <li><strong>修改權</strong>：可編輯或修改任何資料</li>
        <li><strong>刪除權</strong>：可隨時刪除部分或全部資料</li>
        <li><strong>匯出權</strong>：可將資料匯出為 Excel 檔案</li>
        <li><strong>停止使用</strong>：可隨時停止使用本服務</li>
    </ul>

    <h2>7. 資料刪除</h2>
    <p>使用者可透過以下方式刪除資料：</p>
    <ul>
        <li>在工具介面中選擇性刪除特定貼文的資料</li>
        <li>使用「清理工具」批次刪除舊資料</li>
        <li>清除瀏覽器 IndexedDB 儲存空間</li>
        <li>聯繫我們：[您的 email]</li>
    </ul>

    <h2>8. Cookie 和追蹤技術</h2>
    <p>本服務使用：</p>
    <ul>
        <li><strong>LocalStorage</strong>：儲存使用者偏好設定</li>
        <li><strong>IndexedDB</strong>：儲存留言資料</li>
        <li><strong>不使用</strong>追蹤 Cookie 或第三方分析工具</li>
    </ul>

    <h2>9. 第三方服務</h2>
    <p>本服務整合以下第三方：</p>
    <ul>
        <li><strong>Meta (Facebook)</strong>：透過官方 Graph API 取得資料</li>
        <li><strong>Vercel</strong>：應用程式託管平台（僅代理 API 請求）</li>
    </ul>
    <p>我們不會將資料分享給這些平台（僅作為服務基礎設施）。</p>

    <h2>10. 兒童隱私</h2>
    <p>
        本服務不針對 13 歲以下兒童。
        我們不會故意收集兒童的個人資訊。
    </p>

    <h2>11. 政策變更</h2>
    <p>
        我們保留隨時修改本隱私政策的權利。
        重大變更將在本頁面公告，並更新「最後更新」日期。
    </p>

    <h2>12. 聯絡我們</h2>
    <p>如對本隱私政策有任何疑問，請聯繫：</p>
    <ul>
        <li><strong>Email</strong>: [your.email@example.com]</li>
        <li><strong>專案</strong>: https://github.com/jokersosmart/Cursor</li>
    </ul>

    <h2>13. 法律依據</h2>
    <p>
        本服務遵守：
    </p>
    <ul>
        <li>台灣個人資料保護法</li>
        <li>Meta Platform Terms of Service</li>
        <li>Instagram API Terms of Use</li>
        <li>Facebook Platform Policy</li>
    </ul>

    <hr>
    <p class="updated">
        本政策符合 Meta 應用程式審查要求。<br>
        版本：1.0 | 生效日期：2025-11-19
    </p>
</body>
</html>
```

**儲存為**: `privacy-policy.html`

---

### 8.2 使用條款詳細版本

```html
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>使用條款 - 社群留言爬蟲工具</title>
    <style>
        body {
            font-family: Arial, "Microsoft JhengHei", sans-serif;
            max-width: 800px;
            margin: 40px auto;
            padding: 20px;
            line-height: 1.6;
        }
        h1 { color: #2c3e50; }
        h2 { color: #34495e; margin-top: 30px; }
        .updated { color: #7f8c8d; font-size: 14px; }
    </style>
</head>
<body>
    <h1>使用條款</h1>
    <p class="updated">最後更新：2025 年 11 月 19 日</p>

    <h2>1. 接受條款</h2>
    <p>
        使用本服務即表示您同意這些使用條款。
        如果不同意，請勿使用本服務。
    </p>

    <h2>2. 服務說明</h2>
    <p>
        「社群留言爬蟲工具」提供以下功能：
    </p>
    <ul>
        <li>從 Instagram 和 Facebook <strong>公開貼文</strong>收集留言資料</li>
        <li>在線上表格中顯示和編輯留言資料</li>
        <li>將資料匯出為 Excel 檔案</li>
        <li>支援批次處理多個貼文</li>
    </ul>

    <h2>3. 使用限制</h2>
    <p>使用本服務時，您<strong>必須遵守</strong>：</p>
    <ul>
        <li><strong>僅爬取公開內容</strong>：不得嘗試存取私人帳號或受限內容</li>
        <li><strong>合法用途</strong>：僅用於合法的商業分析、研究或個人用途</li>
        <li><strong>尊重著作權</strong>：留言內容著作權歸原作者所有</li>
        <li><strong>遵守平台政策</strong>：遵守 Instagram 和 Facebook 的服務條款</li>
        <li><strong>不得濫用</strong>：不得用於騷擾、垃圾訊息或惡意目的</li>
    </ul>

    <p>您<strong>不得</strong>：</p>
    <ul>
        <li>❌ 嘗試破解或繞過 API 限制</li>
        <li>❌ 大量爬取資料用於轉售或商業資料庫</li>
        <li>❌ 侵犯他人隱私或智慧財產權</li>
        <li>❌ 使用資料進行歧視、騷擾或非法活動</li>
        <li>❌ 反向工程或嘗試竊取 API Token</li>
    </ul>

    <h2>4. API 使用規範</h2>
    <p>
        本服務透過 Meta（Facebook）官方 API 運作，
        您的使用受以下政策約束：
    </p>
    <ul>
        <li><a href="https://developers.facebook.com/terms">Meta Platform Terms</a></li>
        <li><a href="https://developers.facebook.com/policy">Meta Developer Policies</a></li>
        <li><a href="https://help.instagram.com/581066165581870">Instagram Terms of Use</a></li>
    </ul>

    <h2>5. 速率限制</h2>
    <p>
        Meta API 設有速率限制（每小時約 200 次呼叫）。
        所有使用者共用此配額。
    </p>
    <p>若超過限制：</p>
    <ul>
        <li>系統會顯示「請求過於頻繁，請稍後再試」</li>
        <li>您需要等待指定時間後再繼續使用</li>
        <li>這是 Meta 的限制，非本服務的限制</li>
    </ul>

    <h2>6. 服務可用性</h2>
    <p>
        本服務「按現狀」提供，我們不保證：
    </p>
    <ul>
        <li>服務持續不中斷</li>
        <li>完全無錯誤或 bug</li>
        <li>Meta API 持續可用</li>
        <li>爬取資料 100% 完整或準確</li>
    </ul>

    <h2>7. 免責聲明</h2>
    <p>
        在法律允許的最大範圍內：
    </p>
    <ul>
        <li>本服務按現狀提供，無任何明示或暗示的保證</li>
        <li>我們不對任何直接、間接、附帶或衍生損害負責</li>
        <li>使用者自行承擔使用本服務的風險</li>
        <li>我們不對第三方平台（Meta）的行為負責</li>
    </ul>

    <h2>8. 資料所有權</h2>
    <p>
        使用者透過本服務收集的資料屬於：
    </p>
    <ul>
        <li>原始留言內容：歸原留言者所有</li>
        <li>整理後的資料集：使用者可依合理使用原則使用</li>
        <li>自訂欄位和分類：歸使用者所有</li>
    </ul>

    <h2>9. 帳號和安全</h2>
    <p>
        本服務不需要使用者註冊或登入。
        所有資料儲存在使用者瀏覽器本地。
    </p>
    <p>使用者責任：</p>
    <ul>
        <li>保護自己的裝置和瀏覽器安全</li>
        <li>不在公共裝置上使用敏感資料</li>
        <li>定期備份重要資料（匯出 Excel）</li>
    </ul>

    <h2>10. 終止服務</h2>
    <p>
        我們保留在以下情況終止服務的權利：
    </p>
    <ul>
        <li>使用者違反這些使用條款</li>
        <li>Meta 撤銷我們的 API 存取權</li>
        <li>法律或監管要求</li>
    </ul>

    <h2>11. 變更條款</h2>
    <p>
        我們保留隨時修改這些條款的權利。
        重大變更將在本頁面公告。
        繼續使用服務即表示接受新條款。
    </p>

    <h2>12. 管轄法律</h2>
    <p>
        本條款受<strong>中華民國（台灣）法律</strong>管轄。
        任何爭議將由台灣法院管轄。
    </p>

    <h2>13. 聯絡我們</h2>
    <p>如有任何問題或疑慮，請聯繫：</p>
    <ul>
        <li><strong>Email</strong>: [your.email@example.com]</li>
        <li><strong>專案頁面</strong>: https://github.com/jokersosmart/Cursor</li>
    </ul>

    <hr>
    <p class="updated">
        版本：1.0 | 生效日期：2025-11-19
    </p>
</body>
</html>
```

**儲存為**: `terms-of-service.html`

---

### 8.3 部署隱私政策和使用條款

#### 方法 1: GitHub Pages（推薦，免費）⭐

**步驟**:

```powershell
# 1. 建立新的 GitHub repository
# 在 GitHub 網站上：
# - 點擊「New repository」
# - 名稱：app-policies
# - 選擇「Public」
# - 建立 repository

# 2. Clone 到本地
git clone https://github.com/jokersosmart/app-policies.git
cd app-policies

# 3. 建立檔案
# 將上面的 HTML 儲存為：
# - privacy-policy.html
# - terms-of-service.html

# 4. Commit 和 Push
git add .
git commit -m "Add privacy policy and terms of service"
git push origin main

# 5. 啟用 GitHub Pages
# 在 GitHub repository 頁面：
# Settings → Pages
# Source: Deploy from a branch
# Branch: main, / (root)
# 點擊 Save

# 6. 等待部署（約 1-2 分鐘）
# 取得 URL：https://jokersosmart.github.io/app-policies/privacy-policy.html
```

**完成後的 URL**:
- 隱私政策：`https://jokersosmart.github.io/app-policies/privacy-policy.html`
- 使用條款：`https://jokersosmart.github.io/app-policies/terms-of-service.html`

---

#### 方法 2: Vercel（也很簡單）

```bash
# 1. 建立資料夾
mkdir app-policies
cd app-policies

# 2. 建立 public 資料夾
mkdir public

# 3. 將 HTML 檔案放入 public/
# - public/privacy-policy.html
# - public/terms-of-service.html

# 4. 部署到 Vercel
vercel

# 5. 取得 URL
# https://app-policies.vercel.app/privacy-policy.html
```

---

### 8.4 更新 Meta 應用程式設定

**步驟**:
1. 回到 Meta 應用程式控制面板
2. 「設定」→「基本」
3. 更新：
   - **隱私政策 URL**: `https://jokersosmart.github.io/app-policies/privacy-policy.html`
   - **使用條款 URL**: `https://jokersosmart.github.io/app-policies/terms-of-service.html`
4. **儲存變更**

---

### ✅ 步驟 8 完成檢查

- [x] 隱私政策已建立（完整版本）
- [x] 使用條款已建立（完整版本）
- [x] 檔案已部署到公開 URL
- [x] URL 已填入 Meta 設定
- [x] URL 可公開存取（測試開啟）

**預計時間**: 60 分鐘

---

## 步驟 9: 提交審核

### 9.1 檢查申請完整性

**在提交前，確認**:

- [x] 所有權限申請表單已填寫
- [x] 隱私政策 URL 已設定且可存取
- [x] 使用條款 URL 已設定且可存取
- [x] 應用程式網域已設定
- [x] 聯絡 email 有效
- [x] 申請說明清楚且詳細

---

### 9.2 提交審核

**步驟**:

1. 前往「應用程式審查」→「權限和功能」
2. 找到每個已申請的權限
3. 確認狀態為「**In Review**」（審查中）

**如果狀態是「Draft」或「Not Submitted」**:
- 點擊權限
- 檢查表單
- 點擊「**Submit for Review**」

---

### 9.3 審核過程說明

**會發生什麼**:

| 時間 | 狀態 | 說明 |
|------|------|------|
| **提交後** | In Review | Meta 團隊審查中 |
| **1-2 天** | (審查中) | 自動化檢查 |
| **3-5 天** | 人工審查 | 審查員檢查用途和政策 |
| **完成** | Approved ✅ | 權限已通過 |
| **或** | Rejected ❌ | 需要修改後重新提交 |

**平均審核時間**: 3-5 個工作天（週末不計）

---

### 9.4 審核標準（Meta 會檢查什麼）

**Meta 審查要點**:

✅ **會通過的特徵**:
- 清楚說明使用目的
- 隱私政策完整且符合規範
- 僅申請必要的權限
- 使用條款明確
- 應用程式設定完整

❌ **可能被拒的原因**:
- 隱私政策 URL 無法存取（404 錯誤）
- 申請說明模糊或可疑
- 申請過多不必要的權限
- 隱私政策內容不符合要求
- 商業用途但未說明清楚

---

### 9.5 提高審核通過率的技巧

**技巧 1: 詳細且誠實的說明**
```
✅ 好的說明：
「本工具協助企業操作人員收集公開貼文留言，用於客戶意見分析。
使用者輸入貼文網址，系統透過 API 擷取公開留言，資料儲存在使用者瀏覽器本地。」

❌ 不好的說明：
「爬取社群資料」（太簡短、模糊）
```

**技巧 2: 強調隱私保護**
```
在申請表單中明確說明：
- 資料儲存在使用者本地
- 不會上傳到我們的伺服器
- 使用者完全控制資料
```

**技巧 3: 提供詳細的使用流程**
```
使用步驟 1 → 2 → 3 清楚列出
讓審查員理解使用者如何使用
```

**技巧 4: 附上截圖或影片**（可選但有幫助）
```
- 應用程式介面截圖
- 使用流程示範影片
- 錯誤處理範例
```

---

### ✅ 步驟 9 完成檢查

- [x] 所有權限已提交審核
- [x] 狀態顯示「In Review」
- [x] 收到 Meta 的確認郵件（可能）
- [x] 審核進度可在控制面板查看

**預計時間**: 5-10 分鐘提交，3-5 天等待

---

## 步驟 10: 審核期間的開發

**重要**: 不要等待審核！現在就可以開始開發。

### 10.1 使用開發模式 Token

**App Token 立即可用**:
- ✅ 步驟 6 取得的 App Access Token 可以直接使用
- ⚠️ 某些端點可能受限（需要審核通過的權限）
- ✅ 但基本端點（公開貼文留言）通常可用

**測試看看**:
```bash
# 使用您的 Token 測試
curl "https://graph.facebook.com/v18.0/{test-media-id}/comments?access_token=YOUR_TOKEN&limit=5"

# 如果回傳留言資料 → 可以開始開發！
# 如果回傳權限錯誤 → 需要等待審核
```

---

### 10.2 使用 Mock API 開發（推薦）

**即使 API 未通過審核，也能開發 90% 的功能！**

**方法**: 使用 Mock Service Worker (MSW)

```typescript
// frontend/tests/mocks/graph-api.ts
import { rest } from 'msw';

export const handlers = [
  rest.post('/api/instagram/scrape', (req, res, ctx) => {
    // 模擬成功回應
    return res(
      ctx.delay(1000), // 模擬網路延遲
      ctx.json({
        success: true,
        data: {
          comments: [
            {
              id: 'mock_1',
              username: 'test_user',
              text: '測試留言內容',
              timestamp: '2025-11-18T10:30:00Z',
              like_count: 5
            },
            // ... 更多測試資料
          ],
          paging: { cursors: { after: 'mock_cursor' } }
        }
      })
    );
  }),
  
  // 模擬錯誤情況
  rest.post('/api/instagram/scrape', (req, res, ctx) => {
    // 速率限制錯誤
    if (shouldSimulateRateLimit) {
      return res(
        ctx.status(429),
        ctx.json({
          success: false,
          error: 'RATE_LIMIT',
          message: '請求過於頻繁，請等待 15 分鐘'
        })
      );
    }
  })
];
```

**使用 Mock API 可以開發**:
- ✅ 所有前端 UI（100%）
- ✅ 表格編輯功能（100%）
- ✅ Excel 匯出功能（100%）
- ✅ 錯誤處理邏輯（100%）
- ✅ 自動續傳機制（100%）
- ⏳ 真實 API 整合（等審核通過）

---

### 10.3 審核期間的開發計劃

**Day 1-2: 不需 API 的任務**
```
✅ T001-T010: Setup
✅ T018-T024: IndexedDB 設定
✅ T025, T027-T029: 工具模組
✅ T030-T035: UI 元件
```

**Day 3-5: 使用 Mock API**
```
✅ T036-T038: 撰寫測試（使用 MSW）
✅ T044-T047: UI 實作
✅ T048-T050: 錯誤處理
✅ 所有前端邏輯
```

**審核通過後: 整合真實 API**
```
✅ T011-T017: 後端 API 代理
✅ T039-T041: 真實 API 整合
✅ E2E 測試
✅ 部署上線
```

**結果**: 審核通過時，前端已完成 90%！

---

## 步驟 11: 審核結果處理

### 11.1 審核通過 ✅

**收到通知**:
- 📧 Email：「Your permissions have been approved」
- 🔔 控制面板：權限狀態變為「**Approved**」

**下一步**:
1. 慶祝！🎉
2. 立即整合真實 API（T011-T017）
3. 測試真實爬取功能
4. 完成 MVP 開發
5. 部署到 Vercel

---

### 11.2 審核被拒 ❌

**不要擔心！這很常見。**

**收到的資訊**:
- 📧 Email 說明拒絕原因
- 控制面板顯示「**Rejected**」和原因

**常見拒絕原因和解決方案**:

| 拒絕原因 | 解決方案 |
|---------|---------|
| 隱私政策不完整 | 補充缺失的章節（參考上方完整範本）|
| 使用說明不清楚 | 提供更詳細的使用流程和截圖 |
| 用途不符合政策 | 調整說明，強調合法商業用途 |
| URL 無法存取 | 檢查 GitHub Pages 部署，確認 URL 正確 |
| 申請權限過多 | 減少不必要的權限，只申請必要的 |

**重新申請步驟**:
1. 根據拒絕原因修改
2. 更新隱私政策或申請表單
3. 點擊「**重新提交**」（Resubmit）
4. 再次等待審核（通常更快，1-2 天）

---

### 11.3 申訴流程（如果不同意拒絕）

**步驟**:
1. 在控制面板找到被拒的權限
2. 點擊「**申訴**」（Appeal）
3. 說明為何您認為應該通過
4. 提供額外證明文件
5. 提交申訴

**申訴時間**: 2-3 天

---

## 常見問題（FAQ）

### Q1: 一定要有公司才能申請嗎？

**A**: 不用！個人開發者也可以申請。

**建議**:
- 商業帳號選項可以留空
- 在申請說明中提及「個人開發專案」或「學習用途」
- 如果是作品集項目，可以說明「Portfolio project」

---

### Q2: 隱私政策一定要英文嗎？

**A**: 不用，繁體中文完全可以。

**建議**:
- 主要內容用繁體中文（針對台灣使用者）
- 可以提供雙語版本（中英對照）更好
- 確保內容完整且符合 Meta 要求即可

---

### Q3: 審核多久會通過？

**A**: 通常 3-5 個工作天。

**時程**:
- 最快：24 小時內
- 平均：3-5 天
- 較慢：1-2 週（如果需要補充資料）
- 週末和假期不計入

**加快審核的方法**:
- 申請表單完整且清楚
- 隱私政策詳細
- 提供截圖或影片

---

### Q4: 審核沒通過怎麼辦？

**A**: 很常見，不用擔心。

**步驟**:
1. 仔細閱讀拒絕原因
2. 根據原因修改
3. 重新提交（通常會更快通過）

**常見修改**: 補充隱私政策、詳細說明用途

---

### Q5: App Token 會過期嗎？

**A**: App Access Token 永久有效。

**但會失效的情況**:
- 重設 App Secret
- 應用程式被停用
- 違反 Meta 政策

**建議**: 妥善保管，不要外洩

---

### Q6: 可以爬取多少留言？

**A**: 受速率限制約束。

**限制**:
- Instagram: ~200 calls/hour
- Facebook: ~200 calls/hour
- 每次呼叫可取得 50-100 則留言

**計算**:
- 200 calls × 50 留言 = 每小時最多 10,000 則留言
- 實際使用通常遠低於此限制

---

### Q7: 可以爬取私人帳號嗎？

**A**: 不行，僅限完全公開的貼文。

**App Access Token 只能存取**:
- ✅ 完全公開的貼文
- ✅ 完全公開的留言
- ❌ 私人帳號
- ❌ 僅朋友可見的內容
- ❌ 需登入才能看的內容

---

### Q8: 審核期間的 Token 可以用嗎？

**A**: 可以，但功能可能受限。

**通常可以**:
- ✅ 呼叫基本端點
- ✅ 讀取少量公開資料（用於測試）

**可能受限**:
- ⚠️ 某些進階端點
- ⚠️ 大量資料請求
- ⚠️ 特定欄位存取

**建議**: 先用 Mock API 開發，通過後整合真實 API

---

### Q9: Token 要放在哪裡？

**A**: 
- ❌ **絕對不可**放在前端程式碼
- ✅ **必須**放在後端（Serverless Functions）
- ✅ **使用**環境變數（.env.local）
- ✅ **Vercel 部署時**設定在 Environment Variables

---

### Q10: 如果被永久拒絕怎麼辦？

**A**: 很少發生，但有備案。

**備案方案**:
1. 使用測試資料開發（Demo 版本）
2. 考慮第三方社群資料服務（CrowdTangle, Brandwatch）
3. 或調整專案範圍（僅內部使用，不公開部署）

---

## 📞 取得協助

### Meta 官方支援

- **開發者社群**: https://developers.facebook.com/community/
- **文件**: https://developers.facebook.com/docs/
- **支援**: https://developers.facebook.com/support/

### 申請相關問題

- **審核狀態**: 控制面板 →「應用程式審查」
- **問題回報**: 控制面板 →「支援收件匣」

---

## 📋 完整檢查清單（申請前最後確認）

### 必要項目（全部 ✅ 才能提交）

- [ ] Facebook 開發者帳號已註冊並驗證
- [ ] 應用程式已建立
- [ ] App ID 和 App Secret 已記錄
- [ ] App Access Token 已取得並測試
- [ ] Instagram Basic Display 已新增
- [ ] Facebook Login 已新增
- [ ] 應用程式網域已設定
- [ ] 隱私政策已建立並部署（URL 可存取）
- [ ] 使用條款已建立並部署（URL 可存取）
- [ ] 隱私政策和使用條款 URL 已填入 Meta 設定
- [ ] instagram_basic 權限申請表單已填寫
- [ ] instagram_manage_comments 權限申請表單已填寫
- [ ] pages_read_engagement 權限申請表單已填寫
- [ ] 所有權限已提交審核
- [ ] 申請說明詳細且清楚
- [ ] 聯絡 email 有效

### 建議項目（提高通過率）

- [ ] 雙重驗證已啟用
- [ ] 應用程式圖示已上傳
- [ ] 提供應用程式截圖
- [ ] 提供使用流程影片
- [ ] 隱私政策包含所有必要章節
- [ ] 使用條款明確且專業

---

## 🎯 時程總覽

```
第 1 天（2-3 小時）
├── 註冊開發者帳號（15 分鐘）
├── 建立應用程式（15 分鐘）
├── 新增產品（15 分鐘）
├── 取得 Token（10 分鐘）
├── 準備隱私政策和使用條款（60 分鐘）
└── 提交權限審核（30 分鐘）

第 2-6 天（等待審核）
├── 使用 Mock API 開發前端
├── 實作 UI 元件
├── 實作編輯和匯出功能
└── 撰寫測試

第 7 天（審核通過）
├── 整合真實 API
├── 測試真實爬取
└── 部署上線
```

---

## ✅ 下一步

完成此指南後：

1. **立即行動**: 開始步驟 1（註冊帳號）
2. **預留時間**: 2-3 小時完成所有步驟
3. **提交審核**: 不要拖延，越早提交越早通過
4. **開始開發**: 使用 Mock API 開發，不等待審核

---

**指南版本**: 1.0  
**最後更新**: 2025-11-19  
**預計審核時間**: 3-5 個工作天

🚀 **準備好了嗎？開始申請您的第一個 Meta API 吧！**

