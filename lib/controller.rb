require "tty-prompt"

prompt = TTY::Prompt.new

class Controller

    p "Welcome to THE JUNGLE. Where you can rate and comment on your favorite artist events."
    


    def intro                                     
        yes_or_no = PROMPT.yes?("\n\n\nAre you a new user?") do |q|
           q.suffix 'Y/N'
         end
       if yes_or_no 
        user_profile 
       else
        Controller.new_user       
       end
    end
    
    
    def user_profile
        find_user = PROMPT.ask("What is your username?", required: true)
        @@current_user = User.find_by(name: find_user)
       
    end 

    
end
