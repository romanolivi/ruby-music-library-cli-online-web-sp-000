class Genre 
  attr_accessor :name 
  @@all = []
  extend Concerns::Findable

  def initialize(name)
    @name = name
    @songs = []
  end
  
  def artists
    songs.collect {|song| song.artist}.uniq  
  end
  
  def songs 
    @songs 
  end
  
  def save 
    @@all << self 
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def self.create(name)
    genre = Genre.new(name)
    genre.save
    genre
  end
end