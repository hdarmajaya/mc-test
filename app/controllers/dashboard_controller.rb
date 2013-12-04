class DashboardController < ApplicationController
  include DashboardHelper

  def index
    begin
      if params[:start_date].blank?
        @date = DateTime.now.beginning_of_week
        flash.now[:notice] = "Default to current week."
      else
        @date = Date.parse(params[:start_date]).beginning_of_week
      end
    rescue
      flash[:error] = "Invalid date."
      redirect_to(:action => 'index')
      return
    end

    @current_week = @date.strftime("%U").to_i

    filename = params[:search_filename]
    @daily_counters = GgsnCounter.by_day(@date, @date.end_of_week, filename)
    @hourly_counters = GgsnCounter.by_hour(@date, @date.end_of_week, filename)
    @file_counters = GgsnCounter.by_file(@date, @date.end_of_week, filename)
  end

end
