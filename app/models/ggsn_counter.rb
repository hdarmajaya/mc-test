# == Schema Information
#
# Table name: ggsn_counters
#
#  id             :integer          not null, primary key
#  filename       :string(255)
#  calltime       :datetime
#  records_in     :integer
#  records_out    :integer
#  malformed_data :integer
#  missing_data   :integer
#  zero_value     :integer
#  min_too_low    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class GgsnCounter < ActiveRecord::Base
  attr_accessible :calltime, :filename, :malformed_data, :min_too_low, 
    :missing_data, :records_in, :records_out, :zero_value

  def self.terms_for(file)
    suggestions = where("filename like ?", "%#{file}%")
    suggestions.order("filename desc").limit(10).pluck(:filename)
  end

  def self.get_date(file)
    GgsnCounter.where(filename: file).limit(1).pluck(:calltime)
  end

  def self.by_day(from, to, filename)
    select("date(calltime) as calldate,
            sum(records_in) as sum_records_in,
            sum(records_out) as sum_records_out,
            sum(malformed_data) as sum_malformed_data,
            sum(missing_data) as sum_missing_data,
            sum(zero_value) as sum_zero_value,
            sum(min_too_low) as sum_min_too_low")
    .where(calltime: (from..to+1))
    .where("filename like ?", "%#{filename}%")
    .group("date(calltime)")
    .order("date(calltime)")
  end

  def self.by_hour(from, to, filename)
    select("date(calltime) as calldate,
            strftime('%H', calltime) as hour,
            sum(records_in) as sum_records_in,
            sum(records_out) as sum_records_out,
            sum(malformed_data) as sum_malformed_data,
            sum(missing_data) as sum_missing_data,
            sum(zero_value) as sum_zero_value,
            sum(min_too_low) as sum_min_too_low")
    .where(calltime: (from..to+1))
    .where("filename like ?", "%#{filename}%")
    .group("date(calltime)", "strftime('%H', calltime)")
    .order("date(calltime)", "strftime('%H', calltime)")
  end

  def self.by_file(from, to, filename)
    select("date(calltime) as calldate,
            strftime('%H', calltime) as hour,
            filename as file,
            sum(records_in) as sum_records_in,
            sum(records_out) as sum_records_out,
            sum(malformed_data) as sum_malformed_data,
            sum(missing_data) as sum_missing_data,
            sum(zero_value) as sum_zero_value,
            sum(min_too_low) as sum_min_too_low")
    .where(calltime: (from..to+1))
    .where("filename like ?", "%#{filename}%")
    .group("date(calltime)", "strftime('%H', calltime)", :filename)
    .order("date(calltime)", "strftime('%H', calltime)", :filename)
  end

end
