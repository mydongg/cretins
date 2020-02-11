# -*- coding: utf-8 -*-

class Post < ActiveRecord::Base
  validates :title, presence: true, length: {maximum: 100, too_long: "%{count} букв максимум" }
  validates :content, presence: true
  validates :category, presence: true
  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }

  def self.search(search)
    where('title like :pat or content like :pat or category like :pat', :pat => "%#{search}%")
  end
end 


class User < ActiveRecord::Base
  has_secure_password

  validates :username, presence: true, length: {in: 3..20}, uniqueness: true
  validates :password_digest, presence: true
end
