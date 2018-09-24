class PagesController < ApplicationController
  before_action :check_login
  def index
      @users = User.where.not(id: current_user.id).all
      @chats = Chat.joins(:chat_users).where(:chat_users => {:user_id => current_user.id}).all
      render 'index'
  end
end
