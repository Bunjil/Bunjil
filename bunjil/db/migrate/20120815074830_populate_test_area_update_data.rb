class PopulateTestAreaUpdateData < ActiveRecord::Migration
  def up
  	FeedItem.create title: "Path 138, Row 207 2012-07-13 at 05:30:35 GMT",
  		link: "http://earthexplorer.usgs.gov/form/metadatalookup/?collection_id=3373&#x26;entity_id=LE71382072012195EDC00&#x26;pageView=1"
  	
  	# Same as the area.
  	AreaUpdate.create image_url: "http://earthexplorer.usgs.gov/browse/etm/138/207/2012/LE71382072012227EDC00.jpg",
  		band3_url: "http://earthexplorer.usgs.gov/browse/etm/138/207/2012/LE71382072012227EDC00.jpg",
  		band4_url: "http://earthexplorer.usgs.gov/browse/etm/138/207/2012/LE71382072012227EDC00.jpg",
  		:feed_item_id => 1,
  		:cloud_cover => 10,
  		:tl_lat => 10, :tl_lon => 10, :tr_lon => 20, :tr_lat => 10,
  			:br_lon => 20, :br_lat => 20, :bl_lon => 10, :bl_lat => 20
  	
  	# Same as the area.
  	AreaUpdate.create image_url: "http://earthexplorer.usgs.gov/browse/etm/138/207/2012/LE71382072012227EDC00.jpg",
  		band3_url: "http://earthexplorer.usgs.gov/browse/etm/138/207/2012/LE71382072012227EDC00.jpg",
  		band4_url: "http://earthexplorer.usgs.gov/browse/etm/138/207/2012/LE71382072012227EDC00.jpg",
  		:feed_item_id => 1,
  		:cloud_cover => 20,
  		:tl_lat => 15, :tl_lon => 10, :tr_lon => 20, :tr_lat => 10,
  			:br_lon => 20, :br_lat => 20, :bl_lon => 10, :bl_lat => 25

  	Area.create name: "Test", description: "A Test Area",
  		top_lat: 6, left_lon: 10, width: 10, height: 12
  end

  def down
  end
end
