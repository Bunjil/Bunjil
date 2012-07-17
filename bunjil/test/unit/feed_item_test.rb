require 'test_helper'

class FeedItemTest < ActiveSupport::TestCase
  test "can get url" do
  	a = feed_items(:one)
  	assert a.get_formatted_url
  end
end
