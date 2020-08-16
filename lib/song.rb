class Song 
  
  attr_accessor :name
  attr_reader :artist, :genre 
  
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name 
    self.artist = artist if artist
    self.genre = genre if genre 
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
  
   def artist=(artist)
    @artist = artist 
    @artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre
    @genre.songs << self if !@genre.songs.include?(self)
  end
  
  def self.find_by_name(name)
    @@all.find {|song| song.name == name}
  end
  
  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end
  
  def self.new_from_filename(filename)
  filename = filename.split(" - ")
    artist_name = filename[0]
    song_name = filename[1]
    genre_name = filename[2].split(".")[0]
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    song = self.new(song_name, artist, genre)
    song
  end
  
  def self.create_from_filename(filename)
    self.new_from_filename(filename).save
  end
    
  
end