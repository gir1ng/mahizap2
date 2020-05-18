class TasksController < ApplicationController
  before_action :require_login

  def new
    @task = Task.new
  end

  def index
    @task = Task.new
    @tasks = Task.where(user_id: current_user.id)
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = "チェックリストを追加しました"
      redirect_to new_task_url
    else
      render "new"
    end
  end

  private

  def task_params
    params.require(:task).permit(:todo, :not_todo)
  end
end
