class PagesController < ApplicationController
  #before_action :check_login
  def index
    if logged_in?
      @users = User.where.not(id: current_user.id).all
      @chats = Chat.joins(:chat_users).where(:chat_users => {:user_id => current_user.id}).all
    end
    render 'index'
  end
end
