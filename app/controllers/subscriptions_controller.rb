class SubscriptionsController < ApplicationController
  
  def create
    @subscription = Subscription.new(params[:subscription])
    @subscription.save
    respond_to do |format|
      format.html { redirect_to services_path }
      format.js
    end
  end
  
  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy
    respond_to do |format|
      format.html { redirect_to services_path }
      format.js
    end
  end
  
end
