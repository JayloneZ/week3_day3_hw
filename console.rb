require 'pg'
require 'pry'
require_relative './models/artist.rb'
require_relative './models/album.rb'
require_relative './db/sql_runner.rb'

Album.delete_all
Artist.delete_all

artist_1 = Artist.new({
  'stage_name' => 'Yoni'
})

artist_2 = Artist.new({
  'stage_name' => 'Miguel'
})

artist_1.save
artist_2.save

album_1 = Album.new({
  'album_title' => 'Shebang Rulez',
  'genre' => 'Kentucky Fried Chicken',
  'artist_id' => artist_1.id
  })

album_2 = Album.new({
  'album_title' => 'Egglayer',
  'genre' => 'bu-GOK',
  'artist_id' => artist_2.id
})

album_3 = Album.new({
  'album_title' => 'My Maggie',
  'genre' => '80s RnB',
  'artist_id' => artist_2.id
})

album_1.save
album_2.save
album_3.save

binding.pry
nil
