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
Serviceクラスを実装し、
- Model: モデル単体のビジネスロジック、依存関係を定義
- Controller: HTTPレスポンスの管理
- Service: 複数モデルにまたがるデータ取得・変換ロジックと、アプリケーションロジックの定義

とすることで、MVCで発生するFatModelやFatControllerを避け、ディレクトリごとの責務を分離するようにしました。
ServiceクラスはServiceディレクトリを切らず、RailsはModelに処理を書くという思想があることを汲み、modelの下に名前空間を作り、サブモデルのような形で切り出しました。
Serviceクラスの実装で意識したのは

 **`call`メソッドにControllerとServiceクラスのインスタンスメソッドが依存するようにしたこと** です。
 
models/concernにCallbleモジュールを定義し、ここでServiceクラス`call`が呼ばれた時に新しくインスタンスが生成されるようにしました。
また、Serviceクラス内の`call`では定義したインスタンスメソッドを元にアプリケーションロジックを定義しています。
こうすることでControllerはServiceクラスの中身を知る必要はなく、Serviceクラス（正確に言えばクラスないのインスタンスメソッド）もControllerの変更影響を受けずに済みます。

例
```
# songs_controller.rb
def register_sharable_song
    status, result = Song::SharableSongRegister.call(
      user_id: current_user&.id,
      song_id: params[:song_id],
      password: params[:password]
    )
    case status
    when :ok
      render json: { data: result }
    when :error
      render json: { error_code: result }, status: :unprocessable_entity
    end
  end
------------------------

# models/concerns/Callable.rb
module Callable
  extend ActiveSupport::Concern
  # concernで切り出すか、applicationService作ってまとめるかは要検討
  class_methods do
    def call(*args, **kwargs, &block)
      new(*args, **kwargs, &block).call
    end
  end
end
------------------------
# models/song/sharable_song_register.rb
class Song
  class SharableSongRegister
    include Callable
    def initialize(user_id:, song_id:, password:)
        @user_id = user_id
        @song_id = song_id
        @password = password
    end

    def call
      register_song(@user_id, @song_id, @password)
    end

    def register_song(user_id, song_id, password)
        password_setting = SongsPassword.find_by(song_id: song_id)
        if password_setting&.authenticate(password)
          song = UsersSong.create!(user_id: user_id, song_id: song_id)
          [ :ok, song ]
        else
          [ :error, :wrong_password ]
        end
    end
  end
end
```
Serviceクラスの命名は例にもあるように **名詞+アクション**　で命名しており、何をどうするのかというのが一目でわかる命名にしました。

### アーキテクチャ説明
アーキテクチャとしてはMVC+Service(?)である。この設計にした理由としては、LaravelやDjangoで導入されるMVC+Repostiroy+Serivceに触れる機会が多くあり、どの場所に何を描けばいいのかという点が明確であったためRailsでも実装してみようと考えたからです。

```
nfc-sticker-be/
├── app/                    # アプリケーションのメインコード
│   ├── controllers/        # APIエンドポイントの制御
│   │   ├── application_controller.rb
│   │   ├── artists/        # アーティスト関連API
│   │   ├── songs/          # 楽曲関連API
│   │   ├── users/          # ユーザー関連API
│   │   └── concerns/       # コントローラー共通処理
│   ├── models/             # データモデル・ビジネスロジック
│   │   ├── application_record.rb
│   │   ├── artist.rb       # アーティストモデル
│   │   ├── song.rb         # 楽曲モデル
│   │   ├── user.rb         # ユーザーモデル
│   │   ├── jwt_denylist.rb # JWT認証管理
│   │   ├── shared_count.rb # 共有回数管理
│   │   ├── songs_password.rb # 楽曲パスワード
│   │   ├── users_shared_song.rb # ユーザー楽曲共有
│   │   ├── users_song.rb   # ユーザー楽曲関連
│   │   ├── artist/         # アーティスト関連サブモデル
│   │   ├── song/           # 楽曲関連サブモデル
│   │   └── concerns/       # モデル共通処理
│   ├── jobs/               # バックグラウンドジョブ
│   ├── mailers/            # メール送信処理
│   └── views/              # ビューテンプレート
├── config/                 # 設定ファイル
│   ├── application.rb      # アプリケーション設定
│   ├── database.yml        # データベース設定
│   ├── routes.rb           # ルーティング設定
│   ├── environments/       # 環境別設定
│   ├── initializers/       # 初期化設定
│   └── locales/            # 国際化ファイル
├── db/                     # データベース関連
│   ├── schema.rb           # データベーススキーマ
│   ├── seeds.rb            # 初期データ
│   └── migrate/            # マイグレーションファイル
├── spec/                   # テストファイル（RSpec）
│   ├── requests/           # APIテスト
│   └── swagger_helper.rb   # Swagger設定
├── swagger/                # API仕様書
├── docs/                   # ドキュメント
├── lib/                    # ライブラリ・タスク
├── bin/                    # 実行可能ファイル
├── public/                 # 静的ファイル
├── scripts/                # スクリプトファイル
├── tmp/                    # 一時ファイル
├── vendor/                 # 外部ライブラリ
├── Gemfile                 # Ruby依存関係
├── Dockerfile              # Docker設定
├── docker-compose.yml      # Docker Compose設定
└── fly.toml                # Fly.io設定
```

## セットアップ手順
`docker compose build`
`docker compose up -d`
でセットアップできます。


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
`fly deploy`

## コマンド一覧
コンテナ内で操作することが多いと思います。
`docker compose exec web`
で操作してください。


## トラブルシューティング
- 本番環境でバックエンドが応答しない時、マイグレーションができない時はfly.ioのマシンのメモリが足りない可能性があります。一時的に増やしてみてください
- 開発環境におけるdatabase.ymlを編集しています。DBとの接続がうまくいかない時は過去のコミット履歴を参照に修正してください。理由は環境変数の項目に記載しています
  

