class UsersController < ApplicationController

    #method to sign up 
    #users should be logged in immidiately after they sign up 

    def new
        @user = User.new 
        render :new
    end

    
    def user_params
        params.require(:user).permit(:email, :password)
    end

    def create 
        @user = User.new(user_params)    

        if @user.save
            login(@user)
            redirect_to user_url(@user)
        else
            render json: "User not created"
        end
    end

    def index
        @users = User.all 
        render :index
    end


end
