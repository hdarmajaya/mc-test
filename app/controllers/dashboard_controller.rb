class DashboardController < ApplicationController
  include DashboardHelper

  def index
    begin
      @date = params[:start_date] ? 
        Date.parse(params[:start_date]).beginning_of_week : 
        DateTime.now.beginning_of_week
    rescue
      flash[:error] = "Invalid date"
      redirect_to(:action => 'index')
      return
    end

    @current_week = @date.strftime("%U").to_i
    @daily_counters = GgsnCounter.by_day(@date, @date.end_of_week)
    @hourly_counters = GgsnCounter.by_hour(@date, @date.end_of_week)
    @file_counters = GgsnCounter.by_file(@date, @date.end_of_week)
  end

end
