# -*- coding: utf-8 -*-

get '/' do
  @posts = Post.all
  @title = 'Bruh'
  slim :index
end

get '/style.css' do
  sass :main
end

get '/signIn' do
  slim :auth
end

not_found do
  status 404
  slim :not_found
end

error do
  @error = request.env['sinatra_error'].name
  erb :'500'
end