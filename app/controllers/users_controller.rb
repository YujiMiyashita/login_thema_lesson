class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    unless logged_in?
      @user = User.new
    else
      redirect_to root_path, notice: 'すでにログインしています。'
    end
  end


  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path, notice: 'ユーザー登録が完了しました！'
    else
      render 'new'
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
