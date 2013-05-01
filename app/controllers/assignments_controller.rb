class AssignmentsController < ApplicationController
  def new
    @assignment = Assignment.new
    @task = Task.find(params[:task_id])
  end
  
  def create
    @assignment = Assignment.new(params[:assignment])
    @assignment.save
    respond_to do |format|
      format.html do
        redirect_to @assignment.task
      end
      format.js
    end
  end
  
  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.destroy
    respond_to do |format|
      format.js
    end
  end
  
end