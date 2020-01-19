# -*- coding: utf-8 -*-

get '/' do
  @posts = Post.order("created_at DESC").limit(10)
  @title = 'Bruh'
  erb :index
end

get '/posts/:id' do
  @post = Post.find(params[:id])
  @title = @post.title
  @content = @post.content
  erb :'posts/show'
end

get '/auth' do
  erb :auth, :layout => false
end

post '/auth/login' do
  
end

not_found do
  status 404
  slim :not_found
end

error do
  @error = request.env['sinatra_error'].name
  erb :'500'
end
