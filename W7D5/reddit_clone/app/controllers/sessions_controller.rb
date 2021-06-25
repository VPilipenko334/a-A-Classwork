class SessionsController < ApplicationController

    before_action :require_logged_in, only: [:destroy]

    #session --> cookie 
    #session_token --> value of the cookie 
    #reset_session_token --> new key to the session token to validate user 

    #login form // this is for a user to log in 
    #hold the value you put in in case something goes wrong 
    def new 
        @user = User.new
        render :new 
    end 

    #this creates a new user // this is the sign up for 
    def create 
         @user = User.new(params[:user][:username], params[:user][:password] )
         if @user.save 
            login(@user)
            redirect_to users_url
         else 
            flash[:errors] = ["Invalid Username and Password"]
            render :new 
         end 
    end 

    #log out user and surrender and reset their session token/cookie 
    def destroy 
        logout! 
        flash[:success] = ['Successfully logged out!']
        redirect_to new_session_url
    end 
end
