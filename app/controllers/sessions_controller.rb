class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to root_url
    else
      render "new"
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      flash[:success] = "ログインしました"
      redirect_to root_url
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
end
