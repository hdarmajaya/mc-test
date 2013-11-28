class GgsnCounter < ActiveRecord::Base
  attr_accessible :calltime, :filename, :malformed_data, :min_too_low, :missing_data, :records_in, :records_out, :zero_value
end
