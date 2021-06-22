class ApplicationController < ActionController::Base

    def login(user)
        sessions[:sessions_token] = user.reset_session_token!
        @current_user = user         
    end 

    
end
