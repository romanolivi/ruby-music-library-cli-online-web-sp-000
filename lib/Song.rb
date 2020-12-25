require 'pry'

class Song 
  attr_accessor :name
  attr_reader :artist, :genre 
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name 
    self.artist=artist unless artist == nil
    self.genre = genre unless genre == nil 
  end
  
  def genre=(genre)
    @genre = genre 
    genre.songs << self unless genre.songs.include?(self)
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def self.all 
    @@all
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def save
    @@all << self
  end
  
  def self.create(name) 
    song = Song.new(name)
    song.save 
    song
  end 
  
  def self.find_by_name(name)
    @@all.find {|song| song.name == name}
  end
  
  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end
  
  def self.new_from_filename(filename)
    array = filename.split(" - ")
    genre = array[2].gsub(".mp3","")
    artist = array[0]
    song_name = array[1]
    artist_name = Artist.find_or_create_by_name(artist)
    genre_name = Genre.find_or_create_by_name(genre)
    self.new(song_name, artist_name, genre_name)
  end
  
  def self.create_from_filename(filename)
    self.new_from_filename(filename).save
  end
  
    
end







  