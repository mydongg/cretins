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

	def current_user
		if session[:user_id]
			 USERS.find { |u| u.id == session[:user_id] }
		else
			nil
		end
	end
end
