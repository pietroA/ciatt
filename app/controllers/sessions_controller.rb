class SessionsController < ApplicationController
	def new
	end
	
	def create
		@user = User.find_by(name: params[:session][:name])
		unless @user == nil
			if @user.authenticate(params[:session][:password])
				login @user
				flash[:success] = "Bentornato, #{@user.name}?"
				send_user_status true
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
		send_user_status false
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

	def send_user_status user_status 

		unless current_user.online_status
            current_user.online_status = OnlineStatus.find_by(user_id: current_user.id)
			unless current_user.online_status				
                current_user.online_status = OnlineStatus.create!(user_id: current_user.id, online: user_status)
            end
		end
		if current_user.online_status.online != user_status
			current_user.online_status.update_attributes(online: user_status)
		end
		
		ActionCable.server.broadcast 'user_status',
				user: current_user
	end
end
