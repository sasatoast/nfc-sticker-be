# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.openapi_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under openapi_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a openapi_spec tag to the
  # the root example_group in your specs, e.g. describe '...', openapi_spec: 'v2/swagger.json'
  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'NFC Sticker Backend API',
        version: 'v1'
      },
      paths: {},
      components: {
        schemas: {
          SongDetailResponse: {
            type: :object,
            properties: {
              id: {
                type: :integer,
                example: 1,
                description: '楽曲ID'
              },
              source_url: {
                type: :string,
                example: 'https://storage.example.com/songs/pretender.mp3',
                description: '音源(mp3)ファイルのURL'
              },
              picture_url: {
                type: :string,
                example: 'https://example.com/songs/pretender/jacket.jpg',
                description: 'ジャケット画像のURL'
              },
              spotify_url: {
                type: :string,
                example: 'https://open.spotify.com/track/15n0n0gT5b6d5g4g3f4g3g',
                description: 'Spotifyの楽曲リンク'
              },
              apple_url: {
                type: :string,
                example: 'https://music.apple.com/jp/album/pretender/1462432842?i=1462432845',
                description: 'Apple Musicの楽曲リンク'
              },
              artist_name: {
                type: :string,
                example: 'Official髭男dism',
                description: 'アーティスト名'
              },
              artist_id: {
                type: :integer,
                example: 1,
                description: 'アーティストID（外部キー）'
              }
            },
            required: %w[id source_url picture_url artist_id]
          },

          SongNotFoundError: {
            type: :object,
            properties: {
              error: {
                type: :string,
                example: 'Song not found',
                description: '楽曲が存在しない場合のエラーメッセージ'
              }
            }
          }
        }
      },
      servers: [
        {
          url: 'https://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'localhost:3000'
            }
          }
        }
      ]
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The openapi_specs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.openapi_format = :yaml
end
