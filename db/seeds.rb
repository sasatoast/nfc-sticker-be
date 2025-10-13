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
  name: 'sly cat girl',
  picture_url: 'https://gnvhiuupgqsxptsqcdpj.supabase.co/storage/v1/object/sign/artistimages/sly.png?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9lZTRjM2ZjOC1lMTY0LTQ2NGUtYTczMS0xNzRhZTEzNmE0YjAiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhcnRpc3RpbWFnZXMvc2x5LnBuZyIsImlhdCI6MTc2MDI1NDQ1NSwiZXhwIjoyMDc1NjE0NDU1fQ.ucXA-PZU1zGG5eqIgFDB3GZjC-Av-F_jWDBwHbhUGiM',
  spotify_url: 'https://open.spotify.com/intl-ja/artist/0a4sw58M79sQxTkrlW0e8e',
  apple_url: 'https://music.apple.com/jp/artist/sly-cat-girl/1599240617',
  homepage_url: 'https://slycatgirl.ryzm.jp/'
)

artist2 = Artist.create!(
  name: 'oddlazy',
  picture_url: 'https://gnvhiuupgqsxptsqcdpj.supabase.co/storage/v1/object/sign/artistimages/oddlazy.png?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9lZTRjM2ZjOC1lMTY0LTQ2NGUtYTczMS0xNzRhZTEzNmE0YjAiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhcnRpc3RpbWFnZXMvb2RkbGF6eS5wbmciLCJpYXQiOjE3NjAyNTQ3MDIsImV4cCI6MjA3NTYxNDcwMn0.wxNmredPclUaqCy52J04W7KskpZ62ln8z-h9OTQUBDE',
  spotify_url: 'https://open.spotify.com/intl-ja/artist/5kz1mKRaS64lvpuQrHcdml',
  apple_url: 'https://music.apple.com/jp/artist/odd-lazy/1693062201',
  homepage_url: 'https://oddlazy.ryzm.jp/'
)

songs = [
    {
      name: "エンドロール",
      source_url: "https://gnvhiuupgqsxptsqcdpj.supabase.co/storage/v1/object/sign/song/EndRoll.wav?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9lZTRjM2ZjOC1lMTY0LTQ2NGUtYTczMS0xNzRhZTEzNmE0YjAiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJzb25nL0VuZFJvbGwud2F2IiwiaWF0IjoxNzYwMjU1NTQyLCJleHAiOjE3OTE3OTE1NDJ9.sZIiSFmdB7147Q33KXN1-4uUwUh2LrAU01Hopi0EbCE",
      picture_url: "https://gnvhiuupgqsxptsqcdpj.supabase.co/storage/v1/object/sign/songimages/endroll.png?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9lZTRjM2ZjOC1lMTY0LTQ2NGUtYTczMS0xNzRhZTEzNmE0YjAiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJzb25naW1hZ2VzL2VuZHJvbGwucG5nIiwiaWF0IjoxNzYwMjU1NTYxLCJleHAiOjE3OTE3OTE1NjF9.x737G2FxFnzKXNj5bX82afG_cFhfP8FQmqDX-8sAgkE",
      spotify_url: "https://open.spotify.com/intl-ja/track/7yndMnfS17AmtrMKJjyTpg?si=09aed37412fb4a24",
      apple_url: "https://music.apple.com/jp/song/%E3%82%A8%E3%83%B3%E3%83%89%E3%83%AD%E3%83%BC%E3%83%AB/1822111130",
      artist_name: artist1.name
    },
    {
      name: "LIFE",
      source_url: "https://gnvhiuupgqsxptsqcdpj.supabase.co/storage/v1/object/sign/song/LIFE.wav?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9lZTRjM2ZjOC1lMTY0LTQ2NGUtYTczMS0xNzRhZTEzNmE0YjAiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJzb25nL0xJRkUud2F2IiwiaWF0IjoxNzYwMjU1Njg3LCJleHAiOjE3OTE3OTE2ODd9.dwcX93xWw89rfIr6XSKZoKqbx09QFQvdc-PZYzc0wHs",
      picture_url: "https://gnvhiuupgqsxptsqcdpj.supabase.co/storage/v1/object/sign/songimages/life.png?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9lZTRjM2ZjOC1lMTY0LTQ2NGUtYTczMS0xNzRhZTEzNmE0YjAiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJzb25naW1hZ2VzL2xpZmUucG5nIiwiaWF0IjoxNzYwMjU1NjY3LCJleHAiOjE3OTE3OTE2Njd9.gc6bqDwMwYZaFXPeunYEd9bjTTPEI9NGXthAEPfrCiQ",
      spotify_url: "https://open.spotify.com/intl-ja/track/3Mt5ZVKm2LFfuiOcXGjmij?si=eac7654c61764611",
      apple_url: "https://music.apple.com/ug/album/life-single/1673201817",
      artist_name: artist1.name
    },
    {
      name: "JuneStar",
      source_url: "https://gnvhiuupgqsxptsqcdpj.supabase.co/storage/v1/object/sign/song/exmaple.mp3?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9lZTRjM2ZjOC1lMTY0LTQ2NGUtYTczMS0xNzRhZTEzNmE0YjAiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJzb25nL2V4bWFwbGUubXAzIiwiaWF0IjoxNzYwMjU2MDU2LCJleHAiOjE3OTE3OTIwNTZ9.tBq_Ujxn9Ml1_iuCnuisu_-eRtFenhxepE3-HA8xcVI",
      picture_url: "https://gnvhiuupgqsxptsqcdpj.supabase.co/storage/v1/object/sign/songimages/june.png?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9lZTRjM2ZjOC1lMTY0LTQ2NGUtYTczMS0xNzRhZTEzNmE0YjAiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJzb25naW1hZ2VzL2p1bmUucG5nIiwiaWF0IjoxNzYwMjU1ODg0LCJleHAiOjE3OTE3OTE4ODR9.RSn6sniq050LB7gHN87pfxvLmyVHpGtpKT00FdtWADk",
      spotify_url: "https://open.spotify.com/intl-ja/track/3kOvHP7ZTPdD89N2524gZq?si=1460803efc324953",
      apple_url: "https://music.apple.com/jp/song/june-star/1731326640",
      artist_name: artist2.name
    }
  ]


songs.each do |song_data|
  status, result = Song::SecureSongCreator.call(**song_data)

  if status == :ok
    puts "#{song_data[:name]} 登録完了 → パスワード: #{result}"
  else
    puts "#{song_data[:name]} 登録失敗: #{result.join(', ')}"
  end
end


puts "#{Song.count} songs created."
puts 'Seed data created successfully!'


# APIテスト用の　seed

# artist1 = Artist.create!(
#   name: 'Official髭男dism', # nameカラムが存在すると仮定
#   picture_url: 'https://example.com/artists/hige/profile.jpg',
#   spotify_url: 'https://open.spotify.com/artist/0_uIqXfJvWB4zl1hPAi4hB',
#   apple_url: 'https://music.apple.com/jp/artist/official髭男dism/10 Official髭男dism',
#   homepage_url: 'https://higedan.com/'
# )

# artist2 = Artist.create!(
#   name: 'YOASOBI', # nameカラムが存在すると仮定
#   picture_url: 'https://example.com/artists/yoasobi/profile.jpg',
#   spotify_url: 'https://open.spotify.com/artist/64tJ2EAv1R6UaZqc4iOCyj',
#   apple_url: 'https://music.apple.com/jp/artist/yoasobi/1487630793',
#   homepage_url: 'https://www.yoasobi-music.jp/'
# )

# artist3 = Artist.create!(
#   name: 'Vaundy', # nameカラムが存在すると仮定
#   picture_url: 'https://example.com/artists/vaundy/profile.jpg',
#   spotify_url: 'https://open.spotify.com/artist/2IUl3m1H1EQ7QfOKzLOLsq',
#   apple_url: 'https://music.apple.com/jp/artist/vaundy/1473415255',
#   homepage_url: 'https://vaundy.jp/'
# )

# puts "#{Artist.count} artists created."

# --- 楽曲の作成 ---
# songs = [
#   {
#     name: "Pretender",
#     source_url: "https://storage.example.com/songs/pretender.mp3",
#     picture_url: "https://example.com/songs/pretender/jacket.jpg",
#     spotify_url: "https://open.spotify.com/track/15n0n0gT5b6d5g4g3f4g3g",
#     apple_url: "https://music.apple.com/jp/album/pretender/1462432842?i=1462432845",
#     artist_name: artist1.name
#   },
#   {
#     name: "Subtitle",
#     source_url: "https://storage.example.com/songs/subtitle.mp3",
#     picture_url: "https://example.com/songs/subtitle/jacket.jpg",
#     spotify_url: "https://open.spotify.com/track/6DbkL0e4Gk3h4b4b4g3b4g",
#     apple_url: "https://music.apple.com/jp/album/subtitle/1648216335?i=1648216336",
#     artist_name: artist1.name
#   },
#   {
#     name: "夜に駆ける",
#     source_url: "https://storage.example.com/songs/yorunikakeru.mp3",
#     picture_url: "https://example.com/songs/yorunikakeru/jacket.jpg",
#     spotify_url: "https://open.spotify.com/track/3g3g3g3g3g3g3g3g3g3g3g",
#     apple_url: "https://music.apple.com/jp/album/夜に駆ける/1492477610?i=1492477611",
#     artist_name: artist2.name
#   },
#   {
#     name: "アイドル",
#     source_url: "https://storage.example.com/songs/idol.mp3",
#     picture_url: "https://example.com/songs/idol/jacket.jpg",
#     spotify_url: "https://open.spotify.com/track/1g1g1g1g1g1g1g1g1g1g1g",
#     apple_url: "https://music.apple.com/jp/album/アイドル/1680292736?i=1680292737",
#     artist_name: artist2.name
#   },
#   {
#     name: "怪獣の花唄",
#     source_url: "https://storage.example.com/songs/kaiju.mp3",
#     picture_url: "https://example.com/songs/kaiju/jacket.jpg",
#     spotify_url: "https://open.spotify.com/track/2g2g2g2g2g2g2g2g2g2g2g",
#     apple_url: "https://music.apple.com/jp/album/怪獣の花唄/1512474135?i=1512474136",
#     artist_name: artist3.name
#   }
#  ]
