require 'pg'
require_relative './artist.rb'
require_relative '../db/sql_runner.rb'

class Album

attr_reader :id, :artist_id
attr_accessor :album_title, :genre
def initialize(options)
  @id = options['id'] if options['id']
  @album_title = options['album_title']
  @genre = options['genre']
  @artist_id = options['artist_id']
end

def save()
  sql = "
    INSERT INTO albums
    (
      album_title,
      genre,
      artist_id
    )
    VALUES
    (
      $1,
      $2,
      $3
    )
    RETURNING *
  "
  values = [@album_title, @genre, @artist_id]
  @id = SqlRunner.run(sql, values)[0]['id'].to_i
end

def self.all()
  sql = "
    SELECT * FROM albums
  "
  SqlRunner.run(sql, nil).map {|album| Album.new(album)}
end

def self.delete_all()
  sql = "
    DELETE FROM albums
  "
  SqlRunner.run(sql, nil)
end

def delete(id)
  sql = "
    DELETE FROM albums
    WHERE id = $1
  "
  values = [id]
  SqlRunner.run(sql, values)
end

def update()
  sql = "
    UPDATE albums
    SET
    (
      album_title,
      genre
    ) =
    (
      $1,
      $2
    )
    WHERE id = $3
  "
  values = [@album_title, @genre, @id]
  SqlRunner.run(sql, values)
end

def show_artist
  sql = "
    SELECT * FROM artists
    WHERE id = $1
  "
  value = [@artist_id]
  Artist.new(SqlRunner.run(sql, value))
end

end
