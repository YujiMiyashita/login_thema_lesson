module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember #ランダムな文字列を生成し、それをハッシュ化してremember_digestとして保存する
    cookies.permanent.signed[:user_id] = user.id #Cookiesにuser_idを入れる
    cookies.permanent[:remember_token] = user.remember_token #Cookiesにremember_tokenを入れる
  end

  # 現在ログインしているユーザーを返す
  def current_user
    if session[:user_id].present? #セッションが持続している時
      #セッションの情報を元にユーザーを@current_userにセットする
      @current_user ||= User.find_by(id: session[:user_id])
    elsif cookies.signed[:user_id] #セッションが切れたがクッキーにuser_idが残っている時
      user = User.find_by(id: cookies.signed[:user_id])
      #DBにハッシュ化された:remember_digestとCookiesに暗号化された:remember_tokenが一致するかを検証
      if user && user.authenticated_token(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  #remember_digestをDBから削除するとともにCookiesのremember_token, user_idを削除する
  def log_out
    #current_user.forget
    #cookies.delete(:user_id)
    #cookies.delete(:remember_token)
    session[:user_id] = nil
    @current_user = nil
  end

end
