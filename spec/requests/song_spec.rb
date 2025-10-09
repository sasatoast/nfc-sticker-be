require 'swagger_helper'

RSpec.describe 'Songs API', type: :request do
  path '/player/songs/{id}' do
    get '楽曲情報を取得するAPIです。' do
      tags 'Songs'
      produces 'application/json'
      description <<~DESC
        楽曲情報を取得するAPIです。
        - クエリに `share_id` を含めた場合、共有回数を自動的にカウントします。
        - ログイン状態でアクセスした場合、共有曲として自動登録されます。
      DESC

      parameter name: :id, in: :path, type: :integer, description: 'Song ID'
      parameter name: :share_id, in: :query, type: :string, description: '共有識別子(省略可)'

      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/SongDetailResponse'
        run_test!
      end

      response(404, 'not found') do
        schema '$ref' => '#/components/schemas/SongNotFoundError'
        run_test!
      end
    end
  end
end
