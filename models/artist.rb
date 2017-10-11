require 'pg'
require_relative './album.rb'
require_relative '../db/sql_runner.rb'

class Artist

  attr_reader :id
  attr_accessor :stage_name
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @stage_name = options['stage_name']
  end

  def save()
    sql = "
      INSERT INTO artists
      (
        stage_name
      )
      VALUES
      (
        $1
      )
      RETURNING *
    "
    values = [@stage_name]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.all()
    sql = "
      SELECT * FROM artists
    "
    SqlRunner.run(sql, nil).map {|artist| Artist.new(artist)}
  end

  def self.delete_all()
    sql = "
      DELETE FROM artists
    "
    SqlRunner.run(sql, nil)
  end

  def delete(id)
    sql = "
      DELETE FROM artists
      WHERE id = $1
    "
    values = [id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "
      UPDATE artists
      SET
      (
        stage_name
      ) =
      (
        $1
      )
      WHERE id = $2
    "
    values = [@stage_name, @id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "
      SELECT * FROM artists
      WHERE id = $1
    "
    value = [id]
    SqlRunner.run(sql, value).map {|artist| Artist.new(artist)}
  end

  def show_albums
    sql = "
      SELECT * FROM albums
      WHERE artist_id = $1
    "
    value = [@id]
    SqlRunner.run(sql, value).map{|album| Album.new(album)}
  end

end
