# -*- coding: utf-8 -*-

get '/' do
  @posts = Post.order("created_at DESC").limit(10)
  erb :index
end

get '/posts/:id/' do
  @post = Post.find(params[:id])
  @title = @post.title
  @content = @post.content
  erb :'posts/show'
end

get '/posts/new' do
  @title = 'Новая рецензия'
  erb :'posts/create'
end

post '/posts/new' do
  params.delete 'submit'
  @post = Post.create(params)

  if @post.save
    redirect to '/'
  else
    'Пост не был создан'
  end

end

get '/posts/:id/edit/' do
  @title = 'Редактировоание рецензии'
  @post = Post.find(params[:id])
  erb :'posts/edit'
end

put '/posts/:id/edit/' do
  @post = Post.find(params[:id])
  if @post.update_attributes(params[:post])
    redirect to '/'
  else
    erb :'posts/edit'
  end
end

#get '/posts/:id/delete/' do
#  @title = 'Подтвердите удаление'
#  @post = Post.find(params[:id])
#  erb :
#end

delete '/posts/:id/' do
  Post.find(params[:id]).destroy
  redirect to '/'
end

get '/profile/?' do
  @title = 'Профиль'
  erb :profile
end

get '/auth' do
  @title = 'Вход'
  erb :auth, :layout => false
end

post '/auth/login' do
  #отправка формы с авторизацией

end

post '/auth/reg' do
  #отправка формы с регистрацией
  
end

not_found do
  @title = '404'
  status 404
  erb :'404'
end

error do
  @error = request.env['sinatra_error'].name
  erb :'500'
end
