require "tty-prompt"
require "pry"

$prompt = TTY::Prompt.new

class Controller
    @user=nil

    p "Welcome to THE JUNGLE. Where you can rate and comment on your favorite artist events."
    


    def intro                                     
        yes_or_no = $prompt.yes?("\n\n\nAre you a new user?") do |q|
           q.suffix 'Y/N'
         end
       if yes_or_no 
        Controller.new_user 
       else
         user_profile      
       end
    end
    
    
    def user_profile
        find_user = $prompt.ask("What is your username?", required: true)
        @user = User.find_by(name: find_user)
        user_choices
        end 
    
    def user_choices
        user_choice = $prompt.select("What would you like to see?", %w(Past_concerts Artist_ratings Comments))
    
        if user_choice = "Past_concerts"
            @user.return_artists
              
        end
end






 
    
end
