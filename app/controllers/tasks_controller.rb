class TasksController < ApplicationController
  before_action :set_task, only: %i(show edit update destroy)
  def index
    if params[:sort_expired] == "true"
      @tasks = Task.all.order(deadline: "DESC")
    elsif
      @tasks = Task.all.order(created_at: "DESC")
    end
  end

  def show  
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice:"タスク「#{@task.name}」を新規作成しました。"
    else
      render :new 
    end
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      redirect_to tasks_path,notice:"タスク「#{@task.name}」を編集しました。"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスク「#{@task.name}」を削除しました。"
  end

  private
  def task_params
    params.require(:task).permit(:name, :description, :deadline, :status)
  end
  def set_task
    @task = Task.find(params[:id])
  end
end
