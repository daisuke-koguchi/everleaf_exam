class TasksController < ApplicationController
  before_action :set_task, only: %i(show edit update destroy)
  def index
    if params[:sort_expired]
      @tasks = current_user.tasks.deadline.page(params[:page])
    elsif params[:sort_priority]
      @tasks = current_user.tasks.priority.page(params[:page])
    elsif params[:task].present?
      if params[:task][:name].present? && params[:task][:status].present?
        @tasks = current_user.tasks.search_name(params[:task][:name]).search_status(params[:task][:status]).page(params[:page])
      elsif params[:task][:name].present?
        @tasks = current_user.tasks.search_name(params[:task][:name]).page(params[:page])
      elsif params[:task][:status].present?
        @tasks = current_user.tasks.search_status(params[:task][:status]).page(params[:page])
      end
    else 
      @tasks = current_user.tasks.created_at.page(params[:page])
    end
  end

  def show  
  end

  def new
    @task = Task.new
    binding.pry
  end

  def create
    @task = current_user.tasks.build(task_params)
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
    params.require(:task).permit(:name, :description, :deadline, :status, :priority).merge(user_id:current_user.id)
  end
  def set_task
    @task = Task.find(params[:id])
  end
end
