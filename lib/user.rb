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
          puts "\n" * 3
        #  puts "artist name:".colorize(:black ).colorize( :background => :white)
         puts events.artist.name.colorize(:red ).colorize( :background => :white)
         puts "\n"
         puts events.venue
         puts "\n"
         puts  "rating:".colorize(:red)
         puts events.rating
         puts "\n"
         puts  "comments:".colorize(:red)
         puts events.comments
         puts "\n"
        end

         user_choice =$prompt.select("What would you like to do?", %w(Back_to_main_menu) )
        case user_choice
        when "Back_to_main_menu"
           self.user_profile
        end
         # Event.all.select { |event| event.user_id == self.id }
       
    end
    # Artist.all.find_by(id: )
  

    def my_artists_ids
        events.all.map do |event|
            event.artist_id
           
        end
    end

    def return_artists
        my_artists_ids.map { |artist_id| Artist.all.find_by(id: artist_id) } 
      
    end         
    
    def past_concerts
      # # all = my_artists_ids.map { |artist_id| Artist.all.find_by(id: artist_id) } 
      # all.map do |artist| 
      #   artist.name
      # end
      find_artist = $prompt.ask("Whose concerts would you like to see?", required: true)
      response= RestClient.get "https://api.songkick.com/api/3.0/search/artists.json?apikey=ot7CkbkP8gtSafPh&query=#{find_artist}"
      
      parsed_response = JSON.parse(response.body)
      
      artist_id = parsed_response["resultsPage"]["results"]["artist"][0]["id"]
      response2 = RestClient.get "https://api.songkick.com/api/3.0/artists/#{artist_id}/gigography.json?apikey=ot7CkbkP8gtSafPh"

      
      parsed_response2 = JSON.parse(response2.body)
            results = parsed_response2["resultsPage"]["results"]["event"].map do |events|
        events["displayName"]
       end
       
       results.each do |result| 
        puts result
       end 
    end

    def future_concerts
      # all = my_artists_ids.map { |artist_id| Artist.all.find_by(id: artist_id) }
      find_artist = $prompt.ask("Whose concerts would you like to see?", required: true)
      response= RestClient.get "https://api.songkick.com/api/3.0/search/artists.json?apikey=ot7CkbkP8gtSafPh&query=#{find_artist}"
      
      parsed_response = JSON.parse(response.body)
      
      artist_id = parsed_response["resultsPage"]["results"]["artist"][0]["id"]
      response2 = RestClient.get "https://api.songkick.com/api/3.0/artists/#{artist_id}/calendar.json?apikey=ot7CkbkP8gtSafPh"
      

      
      parsed_response2 = JSON.parse(response2.body)
            results = parsed_response2["resultsPage"]["results"]["event"].map do |events|
        events["displayName"]
       end
       
       results.each do |result| 
        puts result
       end 
    end

    def user_profile
      user_choice2 = $prompt.select("What would you like to see?", %w(Rate_event View_my_events View_my_artists))
      case user_choice2
      when "Rate_event" 
        add_artist = $prompt.ask("what artist did you watch ?")
        add_genre = $prompt.ask("what genre is the artist ?")
    
        if Artist.all.find { |artist| artist.name == add_artist }
            new_artist = Artist.all.find { |artist| artist.name == add_artist }
        else
            new_artist = Artist.create(name: add_artist, genre: add_genre)
        end
                       
        add_event = $prompt.ask("what event did you attend (location/venue/date) ?")
        add_rating = $prompt.ask("how would you rate the event ?")
        add_comments = $prompt.ask("Any additional comments")
        new_event = Event.create(artist_id: new_artist.id, user_id: self.id, venue: add_event, rating: add_rating, comments: add_comments)
        puts "event added to profile"
        
        user_choice =$prompt.select("What would you like to do?", %w(Back_to_main_menu) )
          case user_choice
          when "Back_to_main_menu"
             self.user_profile
          end
         end

        case user_choice2
        when "View_my_events"
          self.events_display
      
        end
        
        def return_artist_name
          return_artists.map do |artist|
            artist.name
          end
        end


        case user_choice2
        when "View_my_artists"
            artist_names = return_artists.map do |artist|
                artist.name
            end
            # user_choice = $prompt.select("What artist would you like more info on?", artist_names)
            artist_names.each do |result| 
            puts result
            end
            user_choice =$prompt.select("What would you like to do?", %w(Back_to_main_menu) )
              case user_choice
              when "Back_to_main_menu"
                 self.user_profile
              end
        end
      end
 
    
    def similar_artist
      # all = my_artists_ids.map { |artist_id| Artist.all.find_by(id: artist_id) }
      find_artist = $prompt.ask("view similar artist to your entry", required: true)
      response= RestClient.get "https://api.songkick.com/api/3.0/search/artists.json?apikey=ot7CkbkP8gtSafPh&query=#{find_artist}"
      

      parsed_response = JSON.parse(response.body)
      
      artist_id = parsed_response["resultsPage"]["results"]["artist"][0]["id"]
      response2 = RestClient.get "https://api.songkick.com/api/3.0/artists/#{artist_id}/similar_artists.json?apikey=ot7CkbkP8gtSafPh"
      

      
      parsed_response2 = JSON.parse(response2.body)
            results = parsed_response2["resultsPage"]["results"]["artist"].map do |events|
        events["displayName"]
            end
       
       results.each do |result| 
        puts result
       end 
    end
 
        
  end   