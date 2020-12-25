require "pry"
class MusicLibraryController
  
  def initialize(path = './db/mp3s')
    @path = path unless @path == './db/mp3s'
    MusicImporter.new(path).import 
  end
  
  def call 
    input = ""
    while(input != "exit")
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      input = gets.strip
      
      case input
        when "list songs"
          self.list_songs
        when "list artists"
          self.list_artists
        when "list genres"
          self.list_genres
        when "list artist"
          self.list_songs_by_artist
        when "list genre"
          self.list_songs_by_genre
        when "play song"
          self.play_song
      end
      
    end
  end
  
  def list_songs
    Song.all.sort_by(&:name).each_with_index do |song, i| 
      puts "#{i + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end
  
  def list_artists
    Artist.all.sort_by(&:name).each_with_index do |artist, i| 
      puts "#{i + 1}. #{artist.name}"
    end
  end
  
  def list_genres
    Genre.all.sort_by(&:name).each_with_index do |genre, i| 
      puts "#{i + 1}. #{genre.name}"
    end
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist_input = gets.chomp()
    if artist = Artist.find_by_name(artist_input)
      artist.songs.sort_by(&:name).each_with_index do |song, i| 
        puts "#{i + 1}. #{song.name} - #{song.genre.name}"
      end
    end
  end
  
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre_input = gets.chomp()
    if genre = Genre.find_by_name(genre_input)
      genre.songs.sort_by(&:name).each_with_index do |song, i| 
        puts "#{i + 1}. #{song.artist.name} - #{song.name}"
      end
    end
  end
  
  def play_song
    puts "Which song number would you like to play?"
    song_choice = gets.chomp().to_i
    songs = Song.all 
    if(1..songs.length).include?(song_choice)
      song = Song.all.sort_by(&:name)[song_choice - 1]
    end
    puts "Playing #{song.name} by #{song.artist.name}" if song
  end
  
  
end




