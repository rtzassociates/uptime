class DatabasesController < ApplicationController

  def index
    @databases = Database.search(params[:search]).page(params[:page]).per_page(50)
  end

  def show
    @database = Database.find(params[:id])
  end

  def new
    @database = Database.new
  end

  def edit
    @database = Database.find(params[:id])
  end

  def create
    @database = Database.new(params[:database])

    if @database.save
      redirect_to databases_path, notice: 'Database was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @database = Database.find(params[:id])

    if @database.update_attributes(params[:database])
      expire_fragment @database
      redirect_to databases_path, notice: 'Database was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @database = Database.find(params[:id])
    @database.destroy
    redirect_to databases_url, notice: 'Database was successfully deleted.'
  end
end
