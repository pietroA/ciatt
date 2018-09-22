module Api
  class ChatsController < ActionController::API
    before_action :set_user, only: [:create]
    def create
      chats = Chat.joins(:chat_users).where(:chat_users => {:user_id => current_user.id}).all
      @chat = chats.joins(:chat_users).where(:chat_users => {:user_id => @user.id}).all
      if @chat
        create_chat_users
        render json: @chat
      else
        @chat ||= Chat.new()
        if @chat.save
          render json: @chat
        else
          render json: { status: :unprocessable_entity, :error => @chat.errors }
        end
      end
    end
    private
    def create_chat_users
      chat_user = @chat.chat_users.new(user_id: current_user.id)
      chat_user.save
      chat_user = @chat.chat_users.new(user_id: @user.id)
      chat_user.save      
    end
    def set_user
      @user = User.find(params[:user_id])
    end
  end
end