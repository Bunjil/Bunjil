# == Schema Information
#
# Table name: intersections
#
#  id             :integer          not null, primary key
#  reported       :boolean
#  area_id        :integer
#  area_update_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  x              :integer
#  y              :integer
#  w              :integer
#  h              :integer
#

require 'test_helper'

class IntersectionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
