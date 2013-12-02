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
end
