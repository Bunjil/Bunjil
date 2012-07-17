require 'test_helper'

class AreaUpdateTest < ActiveSupport::TestCase
  test "init from feed" do
  	item = feed_items(:one)
  	#item.get_formatted_url
  	ar = AreaUpdate.new
  	ar.init item

    # if ar.should_update?
    #   ar.save
    #   ar.create_download_job # uses the image downloader
    # end
    assert ar.should_update?, "marked to be updated"
  	#assert ar.tl_lat, "has a value for top left"
  end

  test "no collision" do
  	points = Hash[:y, 32.22544, :h, 1.899, :x, -117.5592, :w, 2.454]
  end
end
