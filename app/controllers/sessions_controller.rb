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
				user_message "#{@user.name} è di nuovo online"
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
		user_message "#{current_user.name} è offline"
		log_out
		redirect_to root_url
	end

	private

	def user_message message_body
		current_user.chat_users.each do |cu|
			message = current_user.messages.new
			message.chat_id = cu.chat_id
			message.body = message_body

			if message.save
				ActionCable.server.broadcast 'messages',
					message: message.as_json
			end
		end
	  end
  
end
