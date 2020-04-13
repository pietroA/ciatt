module Api
  class MessagesController < ActionController::API
    include SessionsHelper
    before_action :set_chat, only: [:index, :create]
    before_action :check_user, only: [:index, :create]
    
    def index
      render json: @chat.messages.order(:created_at).all
    end

    def create
      @message = current_user.messages.new(message_params)
      if @message.save
        ActionCable.server.broadcast 'messages',
          message: @message.as_json
        head :ok
      else
        render json: { status: :unprocessable_entity, :error => @message.errors }
      end

    end
    private
    def message_params
      params.require(:message).permit(:chat_id, :body, :user_id)
    end
    
    def check_user
      unless @chat.chat_users.find_by(user_id: current_user.id)
        redirect_to root_url
      end
    end
    def set_chat
      @chat = Chat.includes(:messages).find(params[:chat_id])
    end

  end
end