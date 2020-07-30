require "pry"
  
  class User < ActiveRecord::Base
    has_many :events
    has_many :artists, through: :events

    def user_events
      events.all.select do |event|
          event.user == self
      end
  end

    def events_display
        user_events.map do |events|
            events.rating
            events.comments
        end
    end

    def my_artists_ids
        events.all.map do |event|
            event.artist_id
           
        end
    end

    # def return_artists
    #     all_artist = []
    #     my_artists_ids.each { |id| all_artist << Artist.all.find_by(id: id) }
    #     binding.pry
    # end         
    
    def return_artists
      all = my_artists_ids.map { |artist_id| Artist.all.find_by(id: artist_id) }
    end

        
        
  end   