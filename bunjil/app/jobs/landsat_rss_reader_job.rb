require 'feedzirra'
require 'nokogiri'

class LandsatRssReaderJob

  def perform
    feed = Feed.find_by_name("LandSat7")
    rss_data = Feedzirra::Feed.fetch_and_parse(feed.url)
    # Note for some reason all tag names are different.

    # If the feed fails to be parses/fetched, just give up.
    return if rss_data.is_a?(Fixnum) 

    rss_data.entries.each do |item|
      # Only new entries: ignore entries with duplicate scene id.
      handle_new_item(item, feed.id) unless FeedItem.find_by_scene_id item.summary.scan(/Scene ID: (\w*)/).first
    end
  end

  # This runs for each new feed.
  def handle_new_item(item, feed_id)
    feed_item          = FeedItem.new
    feed_item.scene_id = item.summary.scan(/Scene ID: (\w*)/).first
    feed_item.feed_id  = feed_id
    feed_item.link     = item.url
    
    feed_item.save
    # Parse for points and url.

    # Create area update with url and feed lat/long points.
    area_update = AreaUpdate.new
    area_update.init(feed_item, item.summary)
    area_update.handle
  end

end
