# -*- coding: utf-8 -*-

class CreateUsers < ActiveRecord::Migration[6.0]
  def self.up
    create_table :users do |user|
      user.string :username
      user.string :password_hash
    end
  end

  def self.down
    drop.table :users
  end
end
