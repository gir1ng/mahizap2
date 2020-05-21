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

      all_tasks = current_user.tasks
      all_tasks.each do |task|
        task.update_attribute(:total_count, task.total_count + 1)
        if (params[:todo] && params[:todo].has_key?(task.id.to_s)) || (params[:not_todo] && params[:not_todo].has_key?(task.id.to_s))
          task.update_attribute(:checked_count, task.checked_count + 1)
        end
      end

      redirect_to graph_url
    else
      flash[:danger] = "1つ以上チェックしてください"
      redirect_to tasks_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
