namespace :supabase do
  desc "Supabaseの接続テストと署名付きURL生成テスト"
  task test: :environment do
    puts "\n" + "=" * 60
    puts "🔧 Supabase 接続テスト"
    puts "=" * 60
    
    # 1. 環境変数チェック
    puts "\n📋 環境変数チェック..."
    if ENV['SUPABASE_URL'].present?
      puts "  ✅ SUPABASE_URL: #{ENV['SUPABASE_URL']}"
    else
      puts "  ❌ SUPABASE_URL が設定されていません"
      next
    end
    
    if ENV['SUPABASE_SERVICE_KEY'].present?
      key = ENV['SUPABASE_SERVICE_KEY']
      puts "  ✅ SUPABASE_SERVICE_KEY: #{key[0..20]}... (#{key.length}文字)"
    else
      puts "  ❌ SUPABASE_SERVICE_KEY が設定されていません"
      next
    end
    
    # 2. 楽曲データチェック
    puts "\n🎵 楽曲データチェック..."
    song = Song.first
    if song
      puts "  ✅ 楽曲が見つかりました"
      puts "     ID: #{song.id}"
      puts "     名前: #{song.name}"
      puts "     元のURL: #{song.source_url}"
    else
      puts "  ⚠️  楽曲データがありません。まずは楽曲を登録してください。"
      next
    end
    
    # 3. 署名付きURL生成テスト
    puts "\n🔐 署名付きURL生成テスト..."
    begin
      signed_url = Supabase::SignedUrlGenerator.call(song.source_url, expires_in: 15.minutes)
      
      if signed_url.include?('token=')
        puts "  ✅ 署名付きURL生成成功！"
        puts "     URL: #{signed_url[0..80]}..."
        puts "     トークン含有: ✅"
        puts "     形式: Supabase JWT形式（有効期限はトークン内に含まれます）"
      else
        puts "  ⚠️  URLが生成されましたが、署名が含まれていません"
        puts "     URL: #{signed_url}"
      end
    rescue => e
      puts "  ❌ エラーが発生しました: #{e.message}"
      puts "     #{e.backtrace.first}"
    end
    
    # 4. SongPlayer統合テスト
    puts "\n🎮 SongPlayer統合テスト..."
    begin
      song_data = Song::SongPlayer.call(song_id: song.id)
      
      if song_data && song_data[:source_url].include?('token=')
        puts "  ✅ SongPlayerで署名付きURL生成成功！"
        puts "     曲名: #{song_data[:name]}"
        puts "     アーティスト: #{song_data[:artist_name]}"
        puts "     署名付きURL: #{song_data[:source_url][0..80]}..."
      else
        puts "  ⚠️  SongPlayerが動作していますが、署名付きURLが生成されていません"
      end
    rescue => e
      puts "  ❌ エラーが発生しました: #{e.message}"
      puts "     #{e.backtrace.first}"
    end
    
    # 5. まとめ
    puts "\n" + "=" * 60
    puts "✅ テスト完了！"
    puts "=" * 60
    puts "\n次のステップ:"
    puts "  1. rails server を起動"
    puts "  2. curl -X GET 'http://localhost:3000/player/songs/#{song.id}' でAPIテスト"
    puts "  3. フロントエンドで実際に楽曲を再生してみる\n\n"
  end
  
  desc "Supabase Storageバケットの情報を表示"
  task bucket_info: :environment do
    puts "\n" + "=" * 60
    puts "📦 Supabase Storage バケット情報"
    puts "=" * 60
    
    puts "\n設定されているURL:"
    puts "  #{ENV['SUPABASE_URL']}/storage/v1"
    
    puts "\n使用しているバケット:"
    puts "  songs (デフォルト)"
    
    puts "\n現在の楽曲データ:"
    Song.limit(5).each do |song|
      puts "  - #{song.name}"
      puts "    source_url: #{song.source_url}"
    end
    
    puts "\n"
  end
end

