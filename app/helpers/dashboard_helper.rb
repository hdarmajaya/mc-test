module DashboardHelper

  def get_hourly_count_by_date(date)
    a = Array.new

    @hourly_counters.each do |hc|
      if Date.parse(hc.calldate) == Date.parse(date)
        a << hc.clone
      end
    end

    return a
  end

  def get_hourly_count_by_file(date)
    a = Array.new

    @file_counters.each do |fc|
      if Date.parse(fc.calldate) == Date.parse(date)
        a << fc.clone
      end
    end

    return a
  end
end
