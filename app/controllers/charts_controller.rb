class ChartsController < ApplicationController
  def events
    unless params[:start_date] == ''
      @start_date = params[:start_date] ? params[:start_date].to_date : 1.week.ago.to_date
    else
      @start_date = 1.week.ago.to_date
    end
  
    unless params[:end_date] == ''
      @end_date = params[:end_date] ? params[:end_date].to_date : Date.today
    else
      @end_date = Date.today
    end
  end

end
