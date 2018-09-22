module Api
  class MessagesController < ActionController::API
    include SessionsHelper
    
    def create
      @message = current_user.messages.new(message_params)
      if @message.save
        render json: @message
      else
        render json: { status: :unprocessable_entity, :error => @message.errors }
      end

    end
    private
    def message_params
      params.require(:message).permit(:chat_id, :body, :user_id)
    end
  end
end