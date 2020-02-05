# -*- coding: utf-8 -*-

class Post < ActiveRecord::Base
  validates :title, presence: true, length: {maximum: 100}
  validates :content, presence: true
  validates :category, presence: true
  validates :rating, presence: true
end 


class User < ActiveRecord::Base
  validates :username, presence: true, length: {minimum: 3, maximum: 20}, uniqueness: true
  validates :password, presence: true
    
  include BCrypt
  
  def password
    @password ||= Password.new(password_hash)
  end
  
  def password=(new_password)
    @password = Password.create(new_password).to_s
    self.password_hash = @password
  end
  
  def create
    @user = User.new(params[:username])
    @user.password = params[:password]
    @user.save!
  end
    
  def login
    @user = User.find { |u| u.username == params[:username] }
    if @user.password == params[:password]
			session.clear
			session[:user_id] = user.id
			redirect to '/'
    else
     redirect to '/auth'
		end
	end
	
end