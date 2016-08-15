class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user) #セッションにuser_idを入れる
      remember(user) #
      redirect_to root_path, notice: 'ログインしました！'
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in? #２つのウィンドウ（タブ）でログインしていた時
    redirect_to root_path, notice: 'ログアウトしました！'
  end
end
