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

require 'test_helper'

class GgsnCounterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
