class TasksController < ApplicationController
  before_action :set_task, only: %i(show edit update destroy)
  def index
    if params[:sort_expired]
      @tasks = Task.deadline.page(params[:page])
    elsif params[:sort_priority]
      @tasks = Task.priority.page(params[:page])
    elsif params[:task].present?
      if params[:task][:name].present? && params[:task][:status].present?
        @tasks = Task.search_name(params[:task][:name]).search_status(params[:task][:status]).page(params[:page])
      elsif params[:task][:name].present?
        @tasks = Task.search_name(params[:task][:name]).page(params[:page])
      elsif params[:task][:status].present?
        @tasks = Task.search_status(params[:task][:status]).page(params[:page])
      end
    else 
      @tasks = Task.created_at.page(params[:page])
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
    params.require(:task).permit(:name, :description, :deadline, :status, :priority)
  end
  def set_task
    @task = Task.find(params[:id])
  end
end
