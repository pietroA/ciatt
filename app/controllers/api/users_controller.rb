class Api::UsersController < ApplicationController
    before_action :set_user, only: [:show]

    def show
        render json: @user.to_json
    end
    private

    def set_user
        @user = User.find(params[:id])
		unless(@user.online_status)
            online_status = OnlineStatus.find_by(user_id: @user.id)
            unless online_status
                @user.online_status = OnlineStatus.create!(user_id: @user.id, online: false)
            end
        end
    end
end
