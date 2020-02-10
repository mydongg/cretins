# -*- coding: utf-8 -*-

class Post < ActiveRecord::Base
  validates :title, presence: true, length: {maximum: 100}
  validates :content, presence: true
  validates :category, presence: true
  validates :rating, presence: true
end 


class User < ActiveRecord::Base
  has_secure_password

  validates :username, presence: true, length: {minimum: 3, maximum: 20}, uniqueness: true
  validates :password_digest, presence: true
end