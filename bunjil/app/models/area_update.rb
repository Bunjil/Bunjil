require 'open-uri'
require 'nokogiri'

class AreaUpdate < ActiveRecord::Base
	# new columns need to be added here to be writable through mass assignment

  # sets all except image url because it's not on the details page.
  # must call save after
  def init(item)
  	doc=Nokogiri::HTML(open(item.get_formatted_url))
  	self.tl_lat=search doc, 'Corner Upper Left Latitude'
  	self.tr_lat=search doc, 'Corner Upper Right Latitude'
  	self.br_lat=search doc, 'Corner Lower Right Latitude'
  	self.bl_lat=search doc, 'Corner Lower Left Latitude'
  	self.tl_lon=search doc, 'Corner Upper Left Longitude'
  	self.tr_lon=search doc, 'Corner Upper Right Longitude'
  	self.br_lon=search doc, 'Corner Lower Right Longitude'
  	self.bl_lon=search doc, 'Corner Lower Left Longitude'
  	self.bl_lon=search doc, 'Corner Lower Left Longitude'
  	self.cloud_cover=search doc, 'Cloud Cover'
  	self.feed_item_id=item.feed_id
  end

  def search(doc,search)
  	basePath = '/html/body/div/table/tbody/tr/td/a[text() ="'
  	doc.xpath(basePath+search+'"]/../../td[2]').text
  end

  # Creates an intersection and returns true if this area meets 
    # cloud cover requirements and intersects with an Area. 
  def should_download?

  end

  # This method creeate image in the queue with image url that
  	# must be already set
  def create_download_job
  	# TODO Aaron
  end

	has_one :area_update_download_task
end
