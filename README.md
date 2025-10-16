## プロジェクト概要
このアプリケーションは、ユーザーがアーティストの物販でNFCタグのついたステッカーを購入し、楽曲を保持曲として登録しユーザー固有のIDを含んだURLを発行し、それをNFCタグに書き込むことで、他のユーザーはステッカーにスマホをかざすだけで楽曲を聴くことができるWEBアプリです。共有数トップ3のユーザーはアーティストページのランキングに掲載されます。インディーズアーティストの口コミでの布教に貢献する目的で作成されました。

### アプリケーションURL
https://nfc-sticker.vercel.app/home
### フロントエンドリポジトリ
https://github.com/sasatoast/nfc-sticker-fe

## 技術スタック
- Backend: Ruby on Rails 8
- Frontend: Next.js (Vercel)
- Database: Supabase (PostgreSQL)
- Container: Docker
- Deployment: Fly.io
- Authentication: Devise + DeviceJWT
- Documentation: Rswag (Swagger UI)
## 開発方針

### アーキテクチャ説明

かくかくのディテクトリ図とディレクトリごとの説明

モデルの振る舞いとサービスクラスの意図、コントローラー、サービスクラスの依存関係

## セットアップ手順


## 環境変数
環境変数は.env(開発環境)、本番環境のFly.ioではsecrets機能を使用します。

開発環境用(LocalDB)
### 1. 共通設定
| 変数名 | 例 | 説明 |
|--------|----|------|
| RAILS_ENV | production | 実行環境 |
| RAILS_MAX_THREADS | 5 | スレッド数制御 |

  (備考：Fly.ioでデプロイするにあたり、database.ymlのdevelopment項目を参照してしまい、解消できなかったため、デフォルトでproductionのDB設定を参照するように変更しています。開発の際は編集してください。)

### 2. Local DB (for development)
| 変数名 | 例 | 説明 |
|--------|----|------|
| DATABASE_NAME | app_development | DB名 |
| DATABASE_USERNAME | app_user | ユーザー名 |
| DATABASE_PASSWORD | app_pass | パスワード |
| DATABASE_HOST | db | Dockerのサービス名 |
| DATABASE_PORT | 5432 | ポート番号 |

### 3. Production (Supabase)
| 変数名 | 例 | 説明 |
|--------|----|------|
| DATABASE_URL | postgresql://... | Supabaseの接続URL |

### 4. Secrets
| 変数名 | 説明 |
|--------|------|
| SECRET_KEY_BASE | Railsの暗号化キー |
| DEVISE_JWT_SECRET_KEY | JWT認証の秘密鍵 |

### 5. CORS / Frontend
| 変数名 | 例 | 説明 |
|--------|----|------|
| CORS_ORIGINS | http://localhost:3001 | 開発用CORS設定 |
| FRONTEND_URL | https://xxx.vercel.app | フロントエンドURL |

### 6. Fly.io Secrets 登録コマンド
```bash
fly secrets set DATABASE_URL="..." SECRET_KEY_BASE="..." DEVISE_JWT_SECRET_KEY="..." RAILS_ENV=production
```


## Swagger
https://nfc-sticker-be.fly.dev/api-docs/index.html

## デプロイ

## コマンド一覧

## トラブルシューティング
- 本番環境でバックエンドが応答しない時、マイグレーションができない時はfly.ioのマシンのメモリが足りない可能性があります。一時的に増やしてみてください
- 開発環境におけるdatabase.ymlを編集しています。DBとの接続がうまくいかない時は過去のコミット履歴を参照に修正してください。理由は環境変数の項目に記載しています
  

