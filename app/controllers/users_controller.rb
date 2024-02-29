class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :logout]
  def index
    @users = User.all
  end
  def show
    # 正しいパラメータが渡された場合のみユーザーを検索
    if params[:id] && params[:id] != 'sign_out'
      @user = User.find(params[:id])
    else
      flash[:error] = "Invalid user ID"
      redirect_to root_path
    end
  end
  def edit
    @user = User.find(params[:id])
    if @user != current_user
        redirect_to user_path(current_user), alert: "不正なアクセスです。"
    end
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザー情報を更新しました。"
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :profile, :profile_image)
  end
end
