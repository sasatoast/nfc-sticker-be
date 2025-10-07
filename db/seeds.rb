# db/seeds.rb

# --- 既存のデータをクリア ---
puts 'Destroying existing songs...'
Song.destroy_all
puts 'Destroying existing artists...'
Artist.destroy_all

puts 'Creating new seed data...'

# --- アーティストの作成 ---
# 楽曲はアーティストに依存するため、先にアーティストを作成します。
puts 'Creating artists...'

artist1 = Artist.create!(
  name: 'Official髭男dism', # nameカラムが存在すると仮定
  picture_url: 'https://example.com/artists/hige/profile.jpg',
  spotify_url: 'https://open.spotify.com/artist/0_uIqXfJvWB4zl1hPAi4hB',
  apple_url: 'https://music.apple.com/jp/artist/official髭男dism/10 Official髭男dism',
  homepage_url: 'https://higedan.com/'
)

artist2 = Artist.create!(
  name: 'YOASOBI', # nameカラムが存在すると仮定
  picture_url: 'https://example.com/artists/yoasobi/profile.jpg',
  spotify_url: 'https://open.spotify.com/artist/64tJ2EAv1R6UaZqc4iOCyj',
  apple_url: 'https://music.apple.com/jp/artist/yoasobi/1487630793',
  homepage_url: 'https://www.yoasobi-music.jp/'
)

artist3 = Artist.create!(
  name: 'Vaundy', # nameカラムが存在すると仮定
  picture_url: 'https://example.com/artists/vaundy/profile.jpg',
  spotify_url: 'https://open.spotify.com/artist/2IUl3m1H1EQ7QfOKzLOLsq',
  apple_url: 'https://music.apple.com/jp/artist/vaundy/1473415255',
  homepage_url: 'https://vaundy.jp/'
)

puts "#{Artist.count} artists created."

# --- 楽曲の作成 ---
songs = [
  {
    name: "Pretender",
    source_url: "https://storage.example.com/songs/pretender.mp3",
    picture_url: "https://example.com/songs/pretender/jacket.jpg",
    spotify_url: "https://open.spotify.com/track/15n0n0gT5b6d5g4g3f4g3g",
    apple_url: "https://music.apple.com/jp/album/pretender/1462432842?i=1462432845",
    artist_name: artist1.name
  },
  {
    name: "Subtitle",
    source_url: "https://storage.example.com/songs/subtitle.mp3",
    picture_url: "https://example.com/songs/subtitle/jacket.jpg",
    spotify_url: "https://open.spotify.com/track/6DbkL0e4Gk3h4b4b4g3b4g",
    apple_url: "https://music.apple.com/jp/album/subtitle/1648216335?i=1648216336",
    artist_name: artist1.name
  },
  {
    name: "夜に駆ける",
    source_url: "https://storage.example.com/songs/yorunikakeru.mp3",
    picture_url: "https://example.com/songs/yorunikakeru/jacket.jpg",
    spotify_url: "https://open.spotify.com/track/3g3g3g3g3g3g3g3g3g3g3g",
    apple_url: "https://music.apple.com/jp/album/夜に駆ける/1492477610?i=1492477611",
    artist_name: artist2.name
  },
  {
    name: "アイドル",
    source_url: "https://storage.example.com/songs/idol.mp3",
    picture_url: "https://example.com/songs/idol/jacket.jpg",
    spotify_url: "https://open.spotify.com/track/1g1g1g1g1g1g1g1g1g1g1g",
    apple_url: "https://music.apple.com/jp/album/アイドル/1680292736?i=1680292737",
    artist_name: artist2.name
  },
  {
    name: "怪獣の花唄",
    source_url: "https://storage.example.com/songs/kaiju.mp3",
    picture_url: "https://example.com/songs/kaiju/jacket.jpg",
    spotify_url: "https://open.spotify.com/track/2g2g2g2g2g2g2g2g2g2g2g",
    apple_url: "https://music.apple.com/jp/album/怪獣の花唄/1512474135?i=1512474136",
    artist_name: artist3.name
  }
]

songs.each do |song_data|
  status, result = CreateSongWithPasswordService.call(**song_data)

  if status == :ok
    puts "#{song_data[:name]} 登録完了 → パスワード: #{result}"
  else
    puts "#{song_data[:name]} 登録失敗: #{result.join(', ')}"
  end
end


puts "#{Song.count} songs created."
puts 'Seed data created successfully!'
