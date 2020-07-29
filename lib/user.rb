require 'pry'

class User 

attr_accessor :name , :genre, :location , :event, :artist



def initialize(name)
    @name = name

end

def average_artist_rating(artist)
        artist.all.select do |artist|
        artist.name == artist
          end
end


end

