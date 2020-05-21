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
    @t = Task.all
    tasks = current_user.tasks
    if @todo_percentages.nil?
      @todo_percentages = {}
      @not_todo_percentages = {}
      tasks.each do |task|
        if task.todo.present?
          @todo_percentages[task.todo] = (task.checked_count.to_f / task.total_count * 100).to_s + "%"
        else
          @not_todo_percentages[task.not_todo] = (task.checked_count.to_f / task.total_count * 100).to_s + "%"
        end
      end
    end
  end

  private

  def task_params
    params.require(:task).permit(:todo, :not_todo)
  end
end
