class PagesController < ApplicationController
  def index
    unless	logged_in?
    	redirect_to login_path
    else
      @users = User.where.not(id: current_user.id).all
      @chats = Chat.joins(:chat_users).where(:chat_users => {:user_id => current_user.id}).all
      render 'index'
    end
  end
end
