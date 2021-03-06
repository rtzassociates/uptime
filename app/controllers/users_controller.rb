class UsersController < ApplicationController
  def index
    @users = User.active.search(params[:search]).page(params[:page]).per_page(25)
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to users_path, :notice => "User was successfully created"
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user, :notice => "User was successfully updated"
    else
      render :action => 'edit'
    end
  end
  
  def show
    @user = User.find(params[:id])
    @reported = Event.reported_by(@user).page(params[:page]).per_page(25)
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.deleted_at = Time.zone.now
    @user.save
    redirect_to users_path, :notice => "User was successfully destroyed"
  end
  
  def current_resource
    @current_resource ||= User.find(params[:id]) if params[:id]
  end
end
