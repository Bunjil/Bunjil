require 'spec_helper'

describe AreaUpdate, "area_update" do

  it "loads fixtures".titleize do
    true.should eq(AreaUpdate.count>0)
    true.should eq(Area.count>0)
  end
  it "can get points correctly".titleize do
    area_updates(:au1).get_points.should eq(
      {:height=>10.0,:y=>10.0,:x=>8.0,:width=>17.0})
  end
  it "intersection with skewed bot right".titleize do
    a1 = areas(:a1)
    au=area_updates(:au1)
    au.find_intersection a1
    i=au.intersections.last
    i.x.should eq(10)
    i.y.should eq(10)
    i.w.should eq(10)
    i.h.should eq(8)
  end
  it "intersection with skewed 5 down in the top left".titleize do
    a1 = areas(:a1)
    au=area_updates(:au2)
    au.find_intersection a1
    i=au.intersections.last
    i.x.should eq(10)
    i.y.should eq(14)
    i.w.should eq(10)
    i.h.should eq(4)
  end
  it "intersection with square".titleize do
    a1 = areas(:a1)
    au=area_updates(:au3)
    au.find_intersection a1
    i=au.intersections.last
    i.x.should eq(10)
    i.y.should eq(10)
    i.w.should eq(10)
    i.h.should eq(8)
  end
  it "intersection encapsulated within the area, skewed both bottom points".titleize do
    a1 = areas(:a1)
    au=area_updates(:au4)
    au.find_intersection a1
    i=au.intersections.last
    i.x.should eq(11)
    i.y.should eq(7)
    i.w.should eq(7)
    i.h.should eq(9)
  end
  it "intersection with exact same shape.".titleize do
    a1 = areas(:a1)
    au=area_updates(:au5)
    au.find_intersection a1
    i=au.intersections.last
    i.x.should eq(10)
    i.y.should eq(6)
    i.w.should eq(10)
    i.h.should eq(12)
  end
  it "no intersections. positive long range".titleize do
    a1 = areas(:a1)
    au=area_updates(:au6)
    n=au.intersections.count
    au.find_intersection a1
    # none are added.
    au.intersections.count.should eq(n)
  end
  it "intersection gets added.".titleize do
    n=Intersection.count
    a1 = areas(:a3)
    au=area_updates(:au1)
    au.find_intersection a1
    # none are added.
    Intersection.count.should eq(n+1)
  end
  it "intersection with partially negative area.".titleize do
    area = areas(:a2)
    au=area_updates(:au1)
    au.find_intersection area
    i=au.intersections.last
    i.x.should eq(8)
    i.y.should eq(10)
    i.w.should eq(17)
    i.h.should eq(10)
  end
  it "intersection with partially negative area on 0.".titleize do
    area = areas(:a2)
    au=area_updates(:au6)
    au.find_intersection area
    i=au.intersections.last
    i.x.should eq(0)
    i.y.should eq(0)
    i.w.should eq(9)
    i.h.should eq(5)
  end
  it "intersection with partially negative area and areaUpdate, skewed.".titleize do
    area = areas(:a2)
    au=area_updates(:au7)
    au.find_intersection area
    i=au.intersections.last
    i.x.should eq(-20)
    i.y.should eq(-10)
    i.w.should eq(40)
    i.h.should eq(20)
  end
  it "intersection with partially negative area and completely negative areaUpdate.".titleize do
    area = areas(:a2)
    au=area_updates(:au8)
    au.find_intersection area
    i=au.intersections.last
    i.x.should eq(-20)
    i.y.should eq(-10)
    i.w.should eq(5)
    i.h.should eq(5)
  end
  it "no intersections. negative lat range".titleize do
    a1 = areas(:a2)
    au=area_updates(:au9)
    n=au.intersections.count
    au.find_intersection a1
    # none are added.
    au.intersections.count.should eq(n)
  end
end
    #   #i4
    #   # {:y=>7.0, :h=>9.0, :x=>11.0, :w=>7.0} 
    #   #i3
    #   # {:y=>10.0, :h=>8.0, :x=>10.0, :w=>10.0} 
    #   #i2
    #   # {:y=>14.0, :h=>4.0, :x=>10.0, :w=>10.0} 
    #   #i1
    #   # {:y=>10.0, :h=>8.0, :x=>10.0, :w=>10.0} 
    # FeedItem.create title: "Path 138, Row 207 2012-07-13 at 05:30:35 GMT",
    #   link: "http://earthexplorer.usgs.gov/form/metadatalookup/?collection_id=3373&#x26;entity_id=LE71382072012195EDC00&#x26;pageView=1"
    
    # # Skewed
    #   #10# 8----20
    #   ####   -     -
    #   #20#    15----25
    #   #{:y=>10.0, :h=>10.0, :x=>8.0, :w=>17.0} 
    # AreaUpdate.create image_url: "http://earthexplorer.usgs.gov/browse/etm/138/207/2012/LE71382072012227EDC00.jpg",
    #   band3_url: "http://earthexplorer.usgs.gov/browse/etm/138/207/2012/LE71382072012227EDC00.jpg",
    #   band4_url: "http://earthexplorer.usgs.gov/browse/etm/138/207/2012/LE71382072012227EDC00.jpg",
    #   :feed_item_id => 1,
    #   :cloud_cover => 10,
    #   :tl_lat => 10, :tl_lon => 8, :tr_lon => 20, :tr_lat => 10,
    #     :br_lon => 25, :br_lat => 20, :bl_lon => 15, :bl_lat => 20

    
    # # 5.titleize down, skewed
    #   #14#    ---20
    #   #15# 10-    -
    #   ####  -     -
    #   #25# 10----20
    #   # {:y=>14.0, :h=>11.0, :x=>10.0, :w=>10.0} 
    # AreaUpdate.create image_url: "http://earthexplorer.usgs.gov/browse/etm/138/207/2012/LE71382072012227EDC00.jpg",
    #   band3_url: "http://earthexplorer.usgs.gov/browse/etm/138/207/2012/LE71382072012227EDC00.jpg",
    #   band4_url: "http://earthexplorer.usgs.gov/browse/etm/138/207/2012/LE71382072012227EDC00.jpg",
    #   :feed_item_id => 1,
    #   :cloud_cover => 20,
    #   :tl_lat => 15, :tl_lon => 10, :tr_lon => 20, :tr_lat => 14,
    #     :br_lon => 20, :br_lat => 25, :bl_lon => 10, :bl_lat => 25
    
    # # 
    #   #10#  10----20
    #   ####  -     -
    #   ####  -     -
    #   #20#  10----20
    #   # {:y=>10.0, :h=>10.0, :x=>10.0, :w=>10.0} 
    # AreaUpdate.create image_url: "http://earthexplorer.usgs.gov/browse/etm/138/207/2012/LE71382072012227EDC00.jpg",
    #   band3_url: "http://earthexplorer.usgs.gov/browse/etm/138/207/2012/LE71382072012227EDC00.jpg",
    #   band4_url: "http://earthexplorer.usgs.gov/browse/etm/138/207/2012/LE71382072012227EDC00.jpg",
    #   :feed_item_id => 1,
    #   :cloud_cover => 20,
    #   :tl_lat => 10, :tl_lon => 10, :tr_lon => 20, :tr_lat => 10,
    #     :br_lon => 20, :br_lat => 20, :bl_lon => 10, :bl_lat => 20
    
    # # within area
    #   #7##  11----18
    #   ####  -      -
    #   ####   -    -
    #   #16#   12--16
    #   # {:y=>7.0, :h=>9.0, :x=>11.0, :w=>7.0} 
    # AreaUpdate.create image_url: "http://earthexplorer.usgs.gov/browse/etm/138/207/2012/LE71382072012227EDC00.jpg",
    #   band3_url: "http://earthexplorer.usgs.gov/browse/etm/138/207/2012/LE71382072012227EDC00.jpg",
    #   band4_url: "http://earthexplorer.usgs.gov/browse/etm/138/207/2012/LE71382072012227EDC00.jpg",
    #   :feed_item_id => 1,
    #   :cloud_cover => 20,
    #   :tl_lat => 10, :tl_lon => 10, :tr_lon => 20, :tr_lat => 10,
    #     :br_lon => 20, :br_lat => 20, :bl_lon => 10, :bl_lat => 20

    # Area.create name: "Test", description: "A Test Area",
    #   left_lon: 10, top_lat: 6, width: 10, height: 12
#area
  # left_lon: 10
  # top_lat: 6
  # width: 10
  # height: 12