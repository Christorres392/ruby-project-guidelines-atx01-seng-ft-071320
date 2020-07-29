class Artist < ActiveRecord::Base
    has_many :events
    has_many :users, through: :events


    def artist_events
        events.all.select do |event|
            event.artist == self
        end
    end


    def artist_ratings
        artist_events.map do |event|
            event.rating
        end
    end

    def artist_average_rating
        artist_ratings.sum.to_f / artist_ratings.length
    end


end

