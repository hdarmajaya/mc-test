module DashboardHelper

  def get_beginning_of_week(date)
    if date
      # the date format from JQuery date picker mm/dd/yyyy is not supported
      # so must be converted to standard yyyy-mm-dd.  this should be done
      # using jquery date format but it does not work somehow
      regex = /\d{2}\/\d{2}\/\d{4}/
      if date =~ regex
        date = DateTime.strptime(date,'%m/%d/%Y').strftime("%Y-%m-%d")
      end

      Date.parse(date).beginning_of_week
    else
      DateTime.now.beginning_of_week
    end
  end

  def get_hourly_count_by_date(data, date)
    a = Array.new

    data.each do |hc|
      if Date.parse(hc.calldate) == Date.parse(date)
        a << hc.clone
      end
    end

    return a
  end

end
