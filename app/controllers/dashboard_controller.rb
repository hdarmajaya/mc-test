class DashboardController < ApplicationController
  include DashboardHelper

  def index
    @date = get_beginning_of_week(params[:start_date])
    @current_week = @date.strftime("%U").to_i
    @daily_counters = get_counters_by_day(@date, @date.end_of_week)
    @hourly_counters = get_counters_by_hour(@date, @date.end_of_week)
  end

  def get_counters_by_day(from, to)
    GgsnCounter.select("date(calltime) as calldate,
                        sum(records_in) as sum_records_in,
                        sum(records_out) as sum_records_out,
                        sum(malformed_data) as sum_malformed_data,
                        sum(missing_data) as sum_missing_data,
                        sum(zero_value) as sum_zero_value,
                        sum(min_too_low) as sum_min_too_low")
               .where(calltime: (from..to+1))
               .group("date(calltime)")
               .order("date(calltime)")
  end

  def get_counters_by_hour(from, to)
    GgsnCounter.select("date(calltime) as calldate,
                        strftime('%H', calltime) as hour,
                        sum(records_in) as sum_records_in,
                        sum(records_out) as sum_records_out,
                        sum(malformed_data) as sum_malformed_data,
                        sum(missing_data) as sum_missing_data,
                        sum(zero_value) as sum_zero_value,
                        sum(min_too_low) as sum_min_too_low")
               .where(calltime: (from..to+1))
               .group("date(calltime)", "strftime('%H', calltime)")
               .order("date(calltime)", "strftime('%H', calltime)")
  end

end
