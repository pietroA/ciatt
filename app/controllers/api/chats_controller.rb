module Api
  class ChatsController < ActionController::API
    before_action :set_user, only: [:create]
    include SessionsHelper
    def create
      p @user
      chats = Chat.joins(:chat_users).where(:chat_users => {:user_id => current_user.id}).all
      p chats
      @chat = chats.joins(:chat_users).find_by(:chat_users => {:user_id => @user.id})
      p @chat
      if @chat
        render json: @chat
      else
        @chat ||= Chat.new()
        if @chat.save
          create_chat_users
          render json: @chat
        else
          render json: { status: :unprocessable_entity, :error => @chat.errors }
        end
      end
    end
    private
    def create_chat_users
      chat_user = ChatUser.new(user_id: current_user.id, chat_id: @chat.id)
      chat_user.save
      chat_user2 = ChatUser.new(user_id: @user.id, chat_id: @chat.id)
      chat_user2.save      
    end
    def set_user
      @user = User.find(params[:user_id])
    end
  end
end