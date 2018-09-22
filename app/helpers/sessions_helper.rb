module SessionsHelper
	def login(user)
		session[:user_id] = user.id
	end
	
	def current_user
		if session[:user_id]
			@current_user ||= User.find(session[:user_id])
		else
			nil
		end
	end
	
	def	logged_in?
		!current_user.nil?
	end
	
	def log_out
		session.delete(:user_id)
		@current_user = nil
	end
end
