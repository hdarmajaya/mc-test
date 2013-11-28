class DashboardController < ApplicationController
  include DashboardHelper

  def index
    @date = get_beginning_of_week(params[:start_date])
    @current_week = @date.strftime("%U").to_i
    @daily_counters = get_counters_by_day(@date, @date.end_of_week)
    @hourly_counters = get_counters_by_hour(@date, @date.end_of_week)
  end

  def get_counters_by_day(from, to)
    #GgsnCounter.where(calltime: (from..to)).group("DATE(calltime)").sum(:records_in)
    GgsnCounter.find_by_sql(["select date(calltime) as calldate, 
                                     sum(records_in) as sum_records_in,
                                     sum(records_out) as sum_records_out,
                                     sum(malformed_data) as sum_malformed_data,
                                     sum(missing_data) as sum_missing_data,
                                     sum(zero_value) as sum_zero_value,
                                     sum(min_too_low) as sum_min_too_low
                                from ggsn_counters 
                               where calltime BETWEEN ? AND ?
                            group by date(calltime)", from, to+1])
  end

  def get_counters_by_hour(from, to)
    GgsnCounter.find_by_sql(["select date(calltime) as calldate,
                                     strftime('%H', calltime) as hour,
                                     sum(records_in) as sum_records_in,
                                     sum(records_out) as sum_records_out,
                                     sum(malformed_data) as sum_malformed_data,
                                     sum(missing_data) as sum_missing_data,
                                     sum(zero_value) as sum_zero_value,
                                     sum(min_too_low) as sum_min_too_low
                                from ggsn_counters
                               where calltime BETWEEN ? AND ?
                            group by date(calltime),
                                     strftime('%H', calltime)", from, to+1])
  end

end
