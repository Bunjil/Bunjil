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
#  band3_url    :string(255)
#  band4_url    :string(255)
#


require 'test_helper'

class AreaUpdateTest < ActiveSupport::TestCase

    FeedItem.create title: "Path 138, Row 207 2012-07-13 at 05:30:35 GMT",
      link: "http://earthexplorer.usgs.gov/form/metadatalookup/?collection_id=3373&#x26;entity_id=LE71382072012195EDC00&#x26;pageView=1"
    
    # Skewed
      #10# 8----20
      ####   -     -
      #20#    15----25
      #{:y=>10.0, :h=>10.0, :x=>8.0, :w=>17.0} 
    AreaUpdate.create image_url: "http://earthexplorer.usgs.gov/browse/etm/138/207/2012/LE71382072012227EDC00.jpg",
      band3_url: "http://earthexplorer.usgs.gov/browse/etm/138/207/2012/LE71382072012227EDC00.jpg",
      band4_url: "http://earthexplorer.usgs.gov/browse/etm/138/207/2012/LE71382072012227EDC00.jpg",
      :feed_item_id => 1,
      :cloud_cover => 10,
      :tl_lat => 10, :tl_lon => 8, :tr_lon => 20, :tr_lat => 10,
        :br_lon => 25, :br_lat => 20, :bl_lon => 15, :bl_lat => 20

    
    # 5 down, skewed
      #14#    ---20
      #15# 10-    -
      ####  -     -
      #25# 10----20
      # {:y=>14.0, :h=>11.0, :x=>10.0, :w=>10.0} 
    AreaUpdate.create image_url: "http://earthexplorer.usgs.gov/browse/etm/138/207/2012/LE71382072012227EDC00.jpg",
      band3_url: "http://earthexplorer.usgs.gov/browse/etm/138/207/2012/LE71382072012227EDC00.jpg",
      band4_url: "http://earthexplorer.usgs.gov/browse/etm/138/207/2012/LE71382072012227EDC00.jpg",
      :feed_item_id => 1,
      :cloud_cover => 20,
      :tl_lat => 15, :tl_lon => 10, :tr_lon => 20, :tr_lat => 14,
        :br_lon => 20, :br_lat => 25, :bl_lon => 10, :bl_lat => 25
    
    # 
      #10#  10----20
      ####  -     -
      ####  -     -
      #20#  10----20
      # {:y=>10.0, :h=>10.0, :x=>10.0, :w=>10.0} 
    AreaUpdate.create image_url: "http://earthexplorer.usgs.gov/browse/etm/138/207/2012/LE71382072012227EDC00.jpg",
      band3_url: "http://earthexplorer.usgs.gov/browse/etm/138/207/2012/LE71382072012227EDC00.jpg",
      band4_url: "http://earthexplorer.usgs.gov/browse/etm/138/207/2012/LE71382072012227EDC00.jpg",
      :feed_item_id => 1,
      :cloud_cover => 20,
      :tl_lat => 10, :tl_lon => 10, :tr_lon => 20, :tr_lat => 10,
        :br_lon => 20, :br_lat => 20, :bl_lon => 10, :bl_lat => 20
    
    # within area
      #7##  11----18
      ####  -      -
      ####   -    -
      #16#   12--16
      # {:y=>7.0, :h=>9.0, :x=>11.0, :w=>7.0} 
    AreaUpdate.create image_url: "http://earthexplorer.usgs.gov/browse/etm/138/207/2012/LE71382072012227EDC00.jpg",
      band3_url: "http://earthexplorer.usgs.gov/browse/etm/138/207/2012/LE71382072012227EDC00.jpg",
      band4_url: "http://earthexplorer.usgs.gov/browse/etm/138/207/2012/LE71382072012227EDC00.jpg",
      :feed_item_id => 1,
      :cloud_cover => 20,
      :tl_lat => 10, :tl_lon => 10, :tr_lon => 20, :tr_lat => 10,
        :br_lon => 20, :br_lat => 20, :bl_lon => 10, :bl_lat => 20

    Area.create name: "Test", description: "A Test Area",
      left_lon: 10, top_lat: 6, width: 10, height: 12

      #i4
      # {:y=>7.0, :h=>9.0, :x=>11.0, :w=>7.0} 
      #i3
      # {:y=>10.0, :h=>8.0, :x=>10.0, :w=>10.0} 
      #i2
      # {:y=>14.0, :h=>4.0, :x=>10.0, :w=>10.0} 
      #i1
      # {:y=>10.0, :h=>8.0, :x=>8.0, :w=>10.0} 


  test "correct rectangle creation" do
    assert true
  end
end
