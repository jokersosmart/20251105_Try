/// <reference types="vite/client" />

interface ImportMetaEnv {
  readonly VITE_FB_APP_ID: string;
  readonly VITE_META_API_VERSION: string;
  readonly VITE_APP_NAME: string;
  readonly VITE_API_BASE_URL: string;
  readonly VITE_ENABLE_MOCK: string;
  readonly VITE_ENABLE_FACEBOOK: string;
  readonly VITE_ENABLE_INSTAGRAM: string;
  readonly VITE_DEBUG_MODE: string;
}

interface ImportMeta {
  readonly env: ImportMetaEnv;
}

