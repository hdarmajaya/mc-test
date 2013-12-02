class DashboardController < ApplicationController
  include DashboardHelper

  def index
    begin
      if params[:start_date].blank?
        @date = DateTime.now.beginning_of_week
        #flash[:notice] = "Blank date. Defaulting to current week."
      else
        @date = Date.parse(params[:start_date]).beginning_of_week
      end
    rescue
      flash[:error] = "Invalid date. Defaulting to current week."
      redirect_to(:action => 'index')
      return
    end

    @current_week = @date.strftime("%U").to_i
    @daily_counters = GgsnCounter.by_day(@date, @date.end_of_week)
    @hourly_counters = GgsnCounter.by_hour(@date, @date.end_of_week)
    @file_counters = GgsnCounter.by_file(@date, @date.end_of_week)
  end

end
