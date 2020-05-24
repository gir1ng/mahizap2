class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to root_url
    else
      @user = User.new
      render "new"
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      redirect_back_or root_url
    else
      flash.now[:danger] = "ログインに失敗しました"
      render "new"
    end
  end

  def destroy
    forget(current_user)
    log_out if logged_in?
    redirect_to root_url
  end

  def secret_password_form
  end

  def create_secret_password
    secret_password = params[:secret_password]
    password_confirmation = params[:password_confirmation]
    if secret_password != password_confirmation
      flash[:danger] = "パスワードが一致しません"
      redirect_to secret_password_form_url and return
    end

    if secret_password.length < 4
      flash[:danger] = "パスワードは4文字以上必要です"
      redirect_to secret_password_form_url and return
    end

    current_user.update_attribute(:secret_password, User.digest(secret_password))
    flash[:success] = "パスワードを設定しました"
    redirect_to graph_url
  end
end
