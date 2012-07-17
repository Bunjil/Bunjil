require 'test_helper'

class AreaUpdateTest < ActiveSupport::TestCase
  test "set" do
  	item = feed_items(:one)
  	#item.get_formatted_url
  	ar = AreaUpdate.new
  	ar.init item
  	assert ar.tl_lat
  end
end
