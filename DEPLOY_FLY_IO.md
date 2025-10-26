# Fly.io デプロイガイド

このドキュメントは、nfc-sticker-beをfly.ioの最安プラン（shared-cpu-1x, 256MB RAM）でデプロイする手順を説明します。

## 前提条件

1. fly.ioアカウントの作成
2. flyctlコマンドのインストール

```bash
# macOSの場合
brew install flyctl

# その他のOSはこちら: https://fly.io/docs/hands-on/install-flyctl/
```

3. ログイン
```bash
flyctl auth login
```

## デプロイ手順

### 1. アプリケーションの作成

```bash
cd nfc-sticker-be
flyctl apps create nfc-sticker-be
```

※ アプリ名が既に使用されている場合は、別の名前を使用してください。その場合は`fly.toml`の`app`も変更してください。

### 2. 環境変数の設定

必要な環境変数を設定します：

```bash
# データベース接続URL（Supabase等）
flyctl secrets set DATABASE_URL="postgresql://user:password@host:port/database"

# Rails master key
flyctl secrets set RAILS_MASTER_KEY="$(cat config/master.key)"

# その他の必要な環境変数
flyctl secrets set SECRET_KEY_BASE="$(bundle exec rails secret)"
flyctl secrets set DEVISE_JWT_SECRET_KEY="$(bundle exec rails secret)"

# CORS設定（フロントエンドのURL）
flyctl secrets set FRONTEND_URL="https://your-frontend-url.com"
```

### 3. Dockerfileの指定

fly.tomlを編集して、最適化されたDockerfileを使用します：

```toml
[build]
  dockerfile = "Dockerfile.fly"
```

または、デフォルトのDockerfileを使用する場合は：

```toml
[build]
```

### 4. デプロイ

```bash
flyctl deploy
```

初回デプロイ後、アプリケーションのURLが表示されます。

### 5. デプロイ後の確認

```bash
# アプリケーションの状態確認
flyctl status

# ログの確認
flyctl logs

# アプリケーションを開く
flyctl open
```

## 費用最適化設定

### 自動スケーリング設定

`fly.toml`には以下の設定が含まれており、最安プランで運用できます：

- `auto_stop_machines = 'stop'`: リクエストがない時は自動停止
- `auto_start_machines = true`: リクエストがあれば自動起動
- `min_machines_running = 0`: アイドル時は0台まで縮小可能
- `memory = '256mb'`: 最小メモリ
- `cpu_kind = 'shared'`: 共有CPU

これにより、**使用していない時間は課金されず**、月額費用を大幅に削減できます。

### 推定月額費用

- shared-cpu-1x (256MB): 約 $1.94/月（常時稼働の場合）
- 自動停止を有効にした場合: 使用時間に応じて更に削減

## トラブルシューティング

### マイグレーションエラー

```bash
# 手動でマイグレーションを実行
flyctl ssh console
bundle exec rails db:migrate
```

### メモリ不足エラー

もしメモリ不足が発生した場合は、`fly.toml`のメモリを増やします：

```toml
[[vm]]
  memory = '512mb'  # 256mb から 512mb へ
```

### ログの確認

```bash
# リアルタイムログ
flyctl logs -a nfc-sticker-be

# 過去のログ
flyctl logs -a nfc-sticker-be --lines 100
```

### シークレットの確認

```bash
flyctl secrets list
```

## その他のコマンド

```bash
# SSHでコンソールに接続
flyctl ssh console

# Railsコンソールの起動
flyctl ssh console -C "bin/rails console"

# アプリケーションの再起動
flyctl apps restart

# アプリケーションの削除
flyctl apps destroy nfc-sticker-be
```

## 注意事項

1. **データベース**: fly.ioのPostgreSQLは有料です。既存のSupabase等の外部DBを使用することで費用を抑えられます。
2. **永続ストレージ**: fly.ioのVMは一時的なものです。永続化が必要なデータは外部ストレージを使用してください。
3. **リージョン**: `fly.toml`では東京リージョン（nrt）を指定していますが、必要に応じて変更できます。

## 参考リンク

- [Fly.io Documentation](https://fly.io/docs/)
- [Fly.io Pricing](https://fly.io/docs/about/pricing/)
- [Rails on Fly.io](https://fly.io/docs/rails/getting-started/)

