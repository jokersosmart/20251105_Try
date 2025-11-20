# 任務清單：通用留言擷取工具（MVP: FB + IG）

**Input**: specs/003-universal-comment-scraper/  
**MVP範圍**: Facebook + Instagram（4週）

## Phase 1: Setup（專案初始化）

- [ ] T001 [P] 建立專案結構（frontend/, api/, docs/）
- [ ] T002 [P] 初始化React + TypeScript專案
- [ ] T003 [P] 安裝核心依賴
- [ ] T004 [P] 設定ESLint, Prettier, Tailwind
- [ ] T005 [P] 建立TypeScript類型結構

## Phase 2: 核心架構（平台適配器模式）

- [ ] T006 設計PlatformAdapter抽象介面 src/platforms/base/
- [ ] T007 [P] 實作平台註冊表 src/platforms/registry.ts
- [ ] T008 [P] 實作URL解析工具 src/services/utils/url-parser.ts
- [ ] T009 [P] 實作平台偵測器 src/services/platform-detector.ts

## Phase 3: 認證系統

- [ ] T010 [P] 實作Token管理器（加密儲存）src/services/auth/token-manager.ts
- [ ] T011 [P] 實作憑證儲存（加密）src/services/auth/credential-store.ts
- [ ] T012 [P] 實作認證驗證器 src/services/auth/auth-validator.ts

## Phase 4: Facebook適配器

- [ ] T013 實作FacebookAdapter src/platforms/facebook/FacebookAdapter.ts
- [ ] T014 [P] Facebook API客戶端 src/platforms/facebook/api-client.ts
- [ ] T015 [P] Facebook URL解析 src/platforms/facebook/url-parser.ts
- [ ] T016 後端Facebook代理 api/facebook.ts

## Phase 5: Instagram適配器

- [ ] T017 實作InstagramAdapter src/platforms/instagram/InstagramAdapter.ts
- [ ] T018 [P] Instagram API客戶端 src/platforms/instagram/api-client.ts
- [ ] T019 [P] Instagram URL解析 src/platforms/instagram/url-parser.ts
- [ ] T020 後端Instagram代理 api/instagram.ts

## Phase 6: 擷取引擎

- [ ] T021 實作ScrapeEngine核心 src/services/scraper/scrape-engine.ts
- [ ] T022 [P] 進度追蹤器 src/services/scraper/progress-tracker.ts
- [ ] T023 [P] 結果聚合器 src/services/scraper/result-aggregator.ts

## Phase 7: UI實作

- [ ] T024 [P] 平台選擇介面 src/components/PlatformSelector.tsx
- [ ] T025 [P] Token輸入介面 src/components/TokenInput.tsx
- [ ] T026 [P] 擷取進度顯示 src/components/ScrapeProgress.tsx
- [ ] T027 留言顯示表格 src/components/CommentsTable.tsx
- [ ] T028 [P] Excel匯出按鈕 src/components/ExportButton.tsx

## Phase 8: 整合與測試

- [ ] T029 整合所有功能到主頁面
- [ ] T030 [P] 端到端測試（FB）
- [ ] T031 [P] 端到端測試（IG）
- [ ] T032 效能測試

## Phase 9: Polish

- [ ] T033 [P] 錯誤處理完善
- [ ] T034 [P] UI優化
- [ ] T035 [P] 文件撰寫
- [ ] T036 部署

---

**總任務**: 36（MVP）
**預估**: 4週
**下階段**: 擴展到其他平台

**完成時間**: 2025-11-20

