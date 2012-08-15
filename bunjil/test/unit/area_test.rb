# == Schema Information
#
# Table name: areas
#
#  id          :integer          not null, primary key
#  top_lat     :integer
#  left_lon    :integer
#  width       :integer
#  height      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#  name        :string(255)
#

require 'test_helper'

class AreaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
