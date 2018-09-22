class SessionsController < ApplicationController
	def new
	end
	
	def create
		@user = User.find_by(name: params[:session][:name])
		p @user
		unless @user == nil
			if @user.authenticate(params[:session][:password])
				login @user
				flash[:success] = "Bentornato, #{@user.name}?"
				redirect_to root_url
			else
				flash[:danger] = "Password per #{params[:session][:name]} non corretta"
				redirect_to login_path
			end
		else
			flash[:danger] = "Non sono presenti Utenti di nome #{params[:session][:name]}"
			redirect_to login_path
		end		
	end
	
	def destroy
		log_out
		redirect_to root_url
	end
end
