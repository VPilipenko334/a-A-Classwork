class User < ApplicationRecord

    validates :email, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true 
    validates :password, length: {minimum: 6, allow_nil: true }
    after_initialize :ensure_session_token


    def password
        @password
    end 


    def password=(password)
        @password = password 

         self.password_digest = BCrypt::Password.create(password)
    #the self above refers to a setter method on the user 
    end

    def self.find_by_credentials(email, password)

        user = User.find_by(email: email)

            if user && user.check_password?(password)
                user
            else
                nil
            end

    end

    def is_password?(password)
        password_object = BCrypt::Password.new(self.password_digest)

        password_object.is_password?(password)        
    end

    def ensure_session_token 
        self.session_token ||= SecureRandom::urlsafe_base64
    end 

    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.save!
        self.session_token
    end 

   
end
