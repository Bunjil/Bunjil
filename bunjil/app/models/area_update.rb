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
#

# long is x, lat is y.
# Test Url: http://earthexplorer.usgs.gov/form/metadatalookup/?collection_id=3373&entity_id=LE71382072012227EDC00&pageView=1

require 'open-uri'
require 'nokogiri'

class AreaUpdate < ActiveRecord::Base
# attr_accessor :tl_lat, :br_lat, :tr_lat, :bl_lat, 
	# :tl_lon, :br_lon, :tr_lon, :bl_lon, :cloud_cover, :feed_item_id

  has_one :area_update_download_task

  @@min_cloud_cover = 40	# must be below this
  # Getters
  def min_cloud_cover
  	@@min_cloud_cover
  end

  # sets required information about an image except 
    # the image url because it's not on the details page.
    # must call save after. Must pass in the feed item creating it.
  def init(item, desc)
  	doc=Nokogiri::HTML(open(item.get_formatted_url))
  	self[:tl_lat]=search(doc, 'Corner Upper Left Latitude')
  	self[:tr_lat]=search(doc, 'Corner Upper Right Latitude')
  	self[:br_lat]=search doc, 'Corner Lower Right Latitude'
  	self[:bl_lat]=search doc, 'Corner Lower Left Latitude'
  	self[:tl_lon]=search doc, 'Corner Upper Left Longitude'
  	self[:tr_lon]=search doc, 'Corner Upper Right Longitude'
  	self[:br_lon]=search doc, 'Corner Lower Right Longitude'
  	self[:bl_lon]=search doc, 'Corner Lower Left Longitude'
  	self[:cloud_cover]=search doc, 'Cloud Cover'
  	self[:feed_item_id]=item.id
    image_url=format_image_url desc
    # TODO: use real urls.
    band3_url=image_url
    band4_url=image_url
  end

  # Creates an intersection and returns true if this area meets 
    # cloud cover requirements and intersects with an Area. 
  def should_update?
  	if cloud_cover.to_i<=@@min_cloud_cover
  		true
  	end
  end

  # Return a rectangle with no rotation that encapsulates all corners.
  def get_points
  	allLat=Array.new 
  	allLat << self[:tl_lat].to_f
  	allLat << self[:tr_lat].to_f
  	allLat << self[:bl_lat].to_f
  	allLat << self[:br_lat].to_f
  	allLon=Array.new 
  	allLon << self[:tl_lon].to_f
  	allLon << self[:tr_lon].to_f
  	allLon << self[:bl_lon].to_f
  	allLon << self[:br_lon].to_f
  	y = allLat.min
  	x = allLon.min
  	Hash[:y, y, :h, allLat.max - y, :x, x, :w, allLon.max - x]
  end

  # This method creeate image in the queue with image url that
  	# must be already set
  def create_download_job
  	# TODO Aaron 
  end

  private
  def init
  end
  # uses item.description to get the image url
  def format_image_url raw
    doc=Nokogiri::HTML(raw)
    doc.xpath('//a[1]/@href').text
  end
  # search the lansat specific image page for some text in the table and
    # return it's value.
  def search(doc,search)
    basePath = '/html/body/div/table/tbody/tr/td/a[text() ="'
    doc.xpath(basePath+search+'"]/../../td[2]').text
  end
end
