=begin
The RSS reader job handles new items in the feed and any other jobs needed to be run with data from the new items.
=end
require 'feedzirra'
require 'nokogiri'

class LandsatRssReaderJob

  def perform (limit =- 1, autoDL = false)
    feed = Feed.find_by_name("LandSat7")
    ActiveRecord::Base.logger.debug "Fetching Feed... #{feed.name}"
    area_updates = []
    rss_data = Feedzirra::Feed.fetch_and_parse(feed.url)

    # Note for some reason all tag names are different.
    # If the feed fails to be parsed/fetched, just give up.
    #ActiveRecord::Base.logger.debug " #{rss_data}"
    if (rss_data==0)
     ActiveRecord::Base.logger.error " FAILED TO CONNECT TO Landsat RSS. It may be down, or maybe you don't have an Internet connection."
     return
   end
    
   begin
      rss_data.entries.each_with_index do |item,ind|
        a = nil
        
        # Only new entries: ignore entries with duplicate scene id.
        ActiveRecord::Base.logger.debug 'Reading an RSS feed item...'
        
        scene_id = item.summary.scan(/Scene ID: (\w*)/)[0][0]
        if FeedItem.find_by_scene_id scene_id
          ActiveRecord::Base.logger.debug "This Item already exists in the DB (scene id: #{scene_id})"
        else
          a=handle_new_item(item, feed.id) end 
        
        # only check ones that get saved.
        area_updates.push(a) unless a==nil
        break if ind == limit
      end
    rescue Exception => e
      logger.error " FAILED TO CONNECT TO Landsat RSS. Due to #{e}" 
    end 

    ActiveRecord::Base.logger.debug "Calling intersection checking job with #{area_updates.count} new area updates."
    IntersectionCheckingJob.new.call autoDL
    area_updates
  end

  # This runs for each new feed item.
  def handle_new_item(item, feed_id)
    feed_item          = FeedItem.new
    feed_item.scene_id = item.summary.scan(/Scene ID: (\w*)/)[0][0] # Matches go in a 2D array
    feed_item.feed_id  = feed_id
    feed_item.link     = item.url
    ActiveRecord::Base.logger.debug "This item is new to the database, id: #{feed_item.scene_id}"
    
    if feed_item.save
      # Create area update with url and feed lat/long points.
      area_update = AreaUpdate.new
      
      # return it if it's valid and requires intersection check.
      attrs=init_area_update(feed_item, item.summary)
      if area_update.init(attrs)
        ActiveRecord::Base.logger.debug " **** New Area Update added."
        area_update.save
        return area_update
      else
        ActiveRecord::Base.logger.debug "Rejected due to cloud cover. (It is #{attrs[:cloud_cover]})"
      end
    end
    
    return nil
  end

  def init_area_update(item, desc)
    doc = Nokogiri::HTML(open(item.get_formatted_url))
    # note, these do change.
    attrs = {}
    attrs[:tl_lat]       = search doc, 'Corner UL Latitude Product'
    attrs[:tr_lat]       = search doc, 'Corner UR Latitude Product'
    attrs[:br_lat]       = search doc, 'Corner LR Latitude Product'
    attrs[:bl_lat]       = search doc, 'Corner LL Latitude Product'
    attrs[:tl_lon]       = search doc, 'Corner UL Longitude Product'
    attrs[:tr_lon]       = search doc, 'Corner UR Longitude Product'
    attrs[:br_lon]       = search doc, 'Corner LR Longitude Product'
    attrs[:bl_lon]       = search doc, 'Corner LL Longitude Product'
    attrs[:cloud_cover]  = search doc, 'Cloud Cover'
    attrs[:feed_item_id] = item.id
    attrs[:image_url]    = format_image_url desc
    attrs
  end
  # uses item.description to get the image url
  def format_image_url(raw)
    doc = Nokogiri::HTML(raw)
    doc.xpath('//a[1]/@href').text
  end
  
  # search the lansat specific image page for some text in the table and
  # return it's value.
  def search(doc, search)
    basePath = '/html/body/div/table/tbody/tr/td/a[text() ="'
    doc.xpath(basePath+search+'"]/../../td[2]').text
  end

end
