class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ユーザー登録が完了しました"
      redirect_to root_path
    else
      render "new"
    end
  end

  def save_point
    todo_count = 0
    not_todo_count = 0
    todo_count = params[:todo].values.map(&:to_i).sum if params[:todo]
    not_todo_count = params[:not_todo].values.map(&:to_i).sum if params[:not_todo]
    if params[:todo] || params[:not_todo]
      count = todo_count - not_todo_count
      current_user.update_attribute(:point, current_user.point + count)
      flash[:success] = "#{count}pt貯まりました"
      redirect_to root_url
    else
      flash[:danger] = "1つもチェックされていません"
      redirect_to tasks_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
