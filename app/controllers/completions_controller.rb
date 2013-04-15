class CompletionsController < ApplicationController
  def new
    @completion = Completion.new
  end
  
  def create
    @completion = Completion.new(params[:completion])
    @completion.user_id = current_user.id
    if @completion.save
      CompletionMailer.completion_notification(@completion).deliver
      redirect_to @completion.task, :notice => "Task completion succesfully created"
    else
      render 'new'
    end
  end
  
  def edit
    @task = Task.find(params[:task_id])
    @completion = @task.completion
  end

  def update
    @task = Task.find(params[:task_id])
    @completion = @task.completion
    if @completion.update_attributes(params[:completion])
      redirect_to @completion.task, :notice => "Task completion succesfully updated"
    else
      render 'new'
    end
  end
  
  def destroy
    @completion = Completion.find(params[:id]) 
    @completion.destroy
    flash[:notice] = "Task completion succesfully destroyed"
    redirect_to @completion.task
  end
  
end
