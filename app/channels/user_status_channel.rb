class UserStatusChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_status"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
