# -*- coding: utf-8 -*-

require 'models'

get '/' do
  @posts = Post.order("created_at DESC").limit(10)
  @ses = "Hello #{session[:name]}"
  erb :index
end

get '/protected' do
	protected!
	"Welcome protected"
end

get '/posts/:id/' do
  @post = Post.find(params[:id])
  @title = @post.title
  @content = @post.content
  @category = @post.category
  @rating = @post.rating
  erb :'posts/show'
end

get '/posts/new' do
  @title = 'Новая рецензия'

  if current_user
    erb :'posts/create'
  else
    redirect '/auth'
  end
end

post '/posts/new' do
  params.delete 'submit'
  @post = Post.create(params)

  if @post.save
    redirect to '/'
  else
    redirect to '/posts/new'
    flash[:error] = "Пост не был создан"
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
  #z t,fk 'nj ujdyj ,kznm
end

post '/auth/reg' do
	@user = User.create(params)
	
	if @user.save
		redirect to '/auth'
		flash[:success] = "Регистрация прошла успешно, теперь вы можете войти"
	else
		redirect to '/auth'
		flash[:error] = "Регистрация не удалась"
	end
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
