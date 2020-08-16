class MusicLibraryController
  attr_accessor :path 
  
  def initialize(path = './db/mp3s')
    @path = path 
    MusicImporter.new(@path).import
  end
  
  def call
    
    end
  end
  
  def list_songs
     Song.all.sort{|x, y| x.name <=> y.name}.each_with_index do |s, i| 
       puts "#{i+1}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
     end
  end
  
  def list_artists
     Artist.all.sort{|x, y| x.name <=> y.name}.each_with_index do |a, i|
      puts "#{i+1}. #{a.name}"
    end
  end
  
  def list_genres
    Genre.all.sort{ |x, y| x.name <=> y.name}.each_with_index do |g, i|
      puts "#{i+1}. #{g.name}"
    end
  end
  
   def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip

    if artist = Artist.find_by_name(input)
      artist.songs.sort{|x, y| x.name <=> y.name}.each_with_index do |s, i|
        puts "#{i+1}. #{s.name} - #{s.genre.name}"
      end
    end
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
    
    if genre = Genre.find_by_name(input)
      genre.songs.sort{|x, y| x.name <=> y.name}.each_with_index do |g, i|
        puts "#{i+1}. #{g.artist.name} - #{g.name}"
      end
    end
  end
  
  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip.to_i
    if input > 0 && input <=Song.all.length 
      array = Song.all.sort{ |x, y| x.name <=> y.name}
      song = array[input-1]
      puts "Playing #{song.name} by #{song.artist.name}"
    end
end
  
end

