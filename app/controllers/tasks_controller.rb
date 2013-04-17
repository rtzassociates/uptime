class TasksController < ApplicationController
  include TasksHelper
  require 'will_paginate/array'
  
  def index
    if params[:filter] == "my_tasks"
      @tasks = Task.assigned_to(current_user).paginate(:per_page => 25)
    elsif params[:filter] == "unassigned"
      @tasks = Task.unassigned.paginate(:per_page => 25)
    elsif params[:filter] == "uncompleted"
      @tasks = Task.uncompleted.paginate(:per_page => 25)
    else
      @tasks = Task.page(params[:page]).per_page(25)
    end
  end
  
  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(params[:task])
    
    @task.user_id = current_user.id
    if @task.save
      TaskMailer.task_notification(@task).deliver
      redirect_to @task, :notice => "Task was successfully created"
    else
      render 'new'
    end
  end

  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    
    if @task.update_attributes(params[:task])
      redirect_to @task, :notice => "Task was successfully updated"
    else
      render 'new'
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, :notice => 'Task was successfully destroyed'
  end
  
end
