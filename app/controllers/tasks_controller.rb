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

  def graph
    tasks = current_user.tasks
    if @percentages.nil?
      @percentages = {}
      tasks.each do |task|
        if task.todo.present?
          @percentages[task.todo] = (task.checked_count.to_f / task.total_count * 100).to_s + "%"
        elsif task.not_todo.present?
          @percentages[task.not_todo] = (task.checked_count.to_f / task.total_count * 100).to_s + "%"
        end
      end
    end
  end

  private

  def task_params
    params.require(:task).permit(:todo, :not_todo)
  end
end
