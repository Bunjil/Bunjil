require 'feedzirra'

class LandsatRssReaderJob

  def perform
    feed     = Feed.find_by_name("LandSat7")
    rss_data = Feedzirra::Feed.fetch_and_parse(feed.url)

    rss_data.entries.each do |item|
      unless FeedItem.find_by_title item.title
        feed_item         = FeedItem.new
        feed_item.title   = item.title
        feed_item.feed_id = feed.id
        
        feed_item.save
      end
    end

  end

end
