module ApplicationHelper

  def display_date(date)
    return Date.parse(date).strftime('%a, %d %b %Y')
  end

end
