class ApplicationController < ActionController::Base

    helper_method :current_user


    def log_in_user(user)
        sessions[:sessions_token] = user.reset_session_token!
        @current_user = user         
    end 

    def current_user
        return nil if sessions[:sessions_token].nil?  #if there is no session token, there is no user, therefore no one is logged in 
    
        @current_user ||= User.find_by(session_token: session[:session_token])
    end 

    def logged_in?
        !current_user.nil?

        # !!current_user
    end
    
    def logged_out
        current_user.reset_session_token! if self.logged_in?
        session[:session_token] = nil
        @current_user = nil 
    end


end
