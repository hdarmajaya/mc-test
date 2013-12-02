module ApplicationHelper
  def flash_class(level)
    case level
    when :notice then "alert-info"
    when :success then "alert-success"
    when :error then "alert-danger"
    when :alert then "alert-warning"
    end
  end

  def display_date(date)
    return Date.parse(date).strftime('%a, %d %b %Y')
  end

end
