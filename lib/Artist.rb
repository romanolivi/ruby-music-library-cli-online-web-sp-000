class Artist 
  attr_accessor :name, :songs
  @@all = []
  extend Concerns::Findable 


  def initialize(name)
    @name = name
    @songs = []
  end
  
  def genres
    songs.collect{|song| song.genre}.uniq 
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
    artist = Artist.new(name)
    artist.save
    artist
  end
  
  def add_song(song)
    if(song.artist != self)
      song.artist = self 
    end 
    self.songs << song unless self.songs.include?(song)
  end
end










