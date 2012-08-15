# == Schema Information
#
# Table name: area_updates
#
#  id           :integer          not null, primary key
#  cloud_cover  :integer
#  feed_item_id :integer
#  image_url    :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  tr_lat       :string(255)
#  tr_lon       :string(255)
#  tl_lon       :string(255)
#  tl_lat       :string(255)
#  br_lat       :string(255)
#  br_lon       :string(255)
#  bl_lat       :string(255)
#  bl_lon       :string(255)
#

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
