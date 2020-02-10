# -*- coding: utf-8 -*-

before do
  @current_user = env['warden'].user
end

get '/' do
  @posts = Post.order("created_at DESC").limit(10)

  erb :index
end

#get '/protected' do
#	protected!
#	"Welcome protected"
#end

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

  if authenticated?
    erb :'posts/create'
  else
    redirect '/auth'
  end
end

post '/posts/new' do
  params.delete 'submit'
  post = Post.create(params)

  if post.save
    redirect to '/'
  else
    redirect to '/posts/new'
    flash[:error] = 'Пост не был создан'
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

get '/profile/:id/' do
  @title = "Профиль #{ @current_user.username }"
  @user = User.find(params[:id])
  erb :profile
end

get '/auth' do
  @title = 'Вход'
  erb :auth, :layout => false
end

post '/auth/login' do
  env['warden'].authenticate!
  flash[:success] = "Вы вошли"

  redirect_to = session[:return_to] || '/'
  puts "logged in, redirect to #{redirect_to}".colorize(:green)

  redirect(redirect_to)
end

post '/auth/reg' do
  check_signup_enabled

	user = User.new(username: params['username'], password: params['password'])
	if user.save
    env['warden'].authenticate!
    flash[:success] = 'Регистрация прошла успешно, вы вошли'

    redirect_to = session[:return_to] || '/'
    puts "Logged in, redirect to #{redirect_to}".colorize(:green)
	else
    flash[:error] = 'Регистрация не удалась'
    redirect_to = '/auth'
  end
  
  redirect(redirect_to)
end

get '/logout' do
  env['warden'].logout

  flash[:success] = 'Вы вышли'
  redirect '/'
end

post '/unauthenticated' do
  session[:return_to] = env['warden.options'][:attempted_path]

  flash[:error] = env['warden'].message || 'Логин или пароль введен неправильно'
  redirect '/auth'
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
