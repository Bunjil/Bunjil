class AddLandsat7FeedToFeeds < ActiveRecord::Migration
  def change
  	f = Feed.new
  	f.name = "LandSat7"
  	f.url  = "http://landsat.usgs.gov/Landsat7.rss"
  end
end
