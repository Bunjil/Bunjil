# == Schema Information
#
# Table name: feed_items
#
#  id         :integer          not null, primary key
#  scene_id   :string(255)
#  link       :string(255)
#  feed_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class FeedItemTest < ActiveSupport::TestCase
  test "can get url" do
  	a = feed_items(:one)
  	assert a.get_formatted_url
  end
end
