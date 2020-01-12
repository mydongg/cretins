# -*- coding: utf-8 -*-

class CreatePost < ActiveRecord::Migration[6.0]
  def self.up
    create_table :posts do |post|
      post.string :title
      post.text :content
      post.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
