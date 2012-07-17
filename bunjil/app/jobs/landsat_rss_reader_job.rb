require 'feedzirra'
require 'nokogiri'

class LandsatRssReaderJob

  def perform
    feed = Feed.find_by_name("LandSat7")
    rss_data = Feedzirra::Feed.fetch_and_parse(feed.url)
    unless rss_data.is_a?(Fixnum)
    # work with the feeds object
      rss_data.entries.each do |item|
        unless FeedItem.find_by_title item.title
          # Only new entries: ignore entries with duplicate title.
          handle_new_item item
        end
      end
    end
  end

  # This runs for each new feed.
  def handle_new_item item
    feed_item         = FeedItem.new
    feed_item.title   = item.title
    feed_item.feed_id = feed.id
    feed_item.link   = item.link
    
    feed_item.save
    # Parse for points and url.

    # Create area update with url and feed lat/long points.
    au=AreaUpdate.new
    au.init feed_item
    au.image_url=format_image_url item.description
    puts au.image_url
    if au.should_update?
      au.save
      au.create_download_job # uses the image downloader
    end
  end

  def format_image_url raw
    doc=Nokogiri::HTML(raw)
    doc.xpath('//a[1]/@href').text
  end

end
