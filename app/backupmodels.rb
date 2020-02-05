class User < ActiveRecord::Base
    validates :username, presence: true, length: {minimum: 3, maximum: 20}, uniqueness: true
    validates :password, presence: true
    
    include BCrypt
  
    def password
      @password ||= Password.new(password_hash)
    end
  
    def password=(new_password)
      @password = Password.create(new_password)
      self.password_hash = @password
    end
  
    def create
      @user = User.new(params[:username])
      @user.password = params[:password]
      @user.save!
    end
    
    def login
      @user = User.find_by_username(params[:username])
      if @user.password == params[:password]
        give_token
      else
        redirect to '/'
      end
    end
  end

  Warden::Strategies.add(:password) do
    def valid?
      puts '(Warden::Strategies) valid?'.colorize(:blue)
      params['username'] && params['password']
    end
    
    def authenticate!
      puts '(Warden::Strategies) authenticate!'.colorize(:blue)
      user = User.find_by(username: params['username'])
    
      if user&.authenticate(params['password'])
      puts '(Warden::Strategies) user present and authenticate returns true'.colorize(:green)
      success!(user)
      else
      puts '(Warden::Strategies) could not authenticate'.colorize(:red)
      fail!('Could not log in')
      end
    end
    end