class TaskNotesController < ApplicationController
  def index
    @task_notes = TaskNote.all
  end
  
  def show
    @task_note = TaskNote.find(params[:id])
  end

  def new
    @task_note = TaskNote.new
  end
  
  def create
    @task_note = TaskNote.new(params[:task_note])
    if @task_note.save
      TaskNoteMailer.task_note_notification(@task_note).deliver
      redirect_to @task_note.task, :notice => "Note successfully created"
    else
      flash[:error] = "Note #{@task_note.errors.full_messages.first.downcase}"
      redirect_to @task_note.task
    end
  end

  def edit
    @task_note = TaskNote.find(params[:id])
  end
  
  def update
    @task_note = TaskNote.find(params[:id])
    if @task_note.update_attributes(params[:task_note])
      redirect_to @task_note.task, :notice => "Note successfully updated"
    else
      flash[:error] = "Note #{@task_note.errors.full_messages.first.downcase}"
      redirect_to @task_note.task
    end
  end
  
  def destroy
    @task_note = TaskNote.find(params[:id]) 
    @task_note.destroy
    flash[:notice] = "Note was destroyed"
    redirect_to @task_note.task
  end

end
