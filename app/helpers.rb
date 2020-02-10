# -*- coding: utf-8 -*-

helpers do
	def pretty_date(time)
		time.strftime("%d %b в %R")
	end

	#def protected!
	#	return if authorized?
	#	headers['WWW-Authenticate'] = 'Basic realm = "Restricted Area"'
	#	halt 401, "Not authorized\n"
	#end

	#def authorized?
	#	@auth ||= Rack::Auth::Basic::Request.new(request.env)
	#	@auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == ['admin', 'admin']
	#end

	#def current_user
	#	if session[:user_id]
	#		 USERS.find { |u| u.id == session[:user_id] }
	#	else
	#		nil
	#	end
	#end

	def authenticated?
    env['warden'].user.present?
  end

  def signup_enabled?
    eval(ENV['SIGNUP_ENABLED'])
  end

  def check_signup_enabled
    unless signup_enabled?
      flash[:error] = 'Sign up disabled'
      redirect '/signin'
    end
  end

  def flash_message_classes(name)
    classes = 'rounded-lg p-6 mb-6 mx-4 '
    classes += 'bg-red-200 text-red-900' if name == 'error'
    classes += 'bg-green-200 text-green-900' if name == 'success'
    classes
  end
end
