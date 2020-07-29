require 'pry'

class Artist 

attr_accessor :name , :genre 
@@all =[]

def initialize(name, genre)
    @name = name
    @genre = genre
    self.class.all << self
   
end

def self.all
    @@all
end

end


drake= Artist.new("Drake","Rock")