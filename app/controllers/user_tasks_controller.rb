class UserTasksController < ApplicationController
  
  def create
    @user_task = UserTask.new(params[:user_task])
    @user_task.save
    respond_to do |format|
      format.html { redirect_to tasks_path }
      format.js
    end
  end
  
  def destroy
    @user_task = UserTask.find(params[:id])
    @user_task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_path }
      format.js
    end
  end
  
end