class AddLandsat7FeedToFeeds < ActiveRecord::Migration
  def up
  	f = Feed.new
  	f.name = "LandSat7"
  	f.url  = "http://landsat.usgs.gov/Landsat7.rss"
  	f.save!
  end
end
