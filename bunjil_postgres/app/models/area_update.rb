/
An area update is the relevant information required to update an area pulled from a feed.
/
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
#  band3_url    :string(255)
#  band4_url    :string(255)
#

# long is x, lat is y.
# Test Url: http://earthexplorer.usgs.gov/form/metadatalookup/?collection_id=3373&entity_id=LE71382072012227EDC00&pageView=1

require 'open-uri'
require 'nokogiri'

class AreaUpdate < ActiveRecord::Base
# attr_accessor :tl_lat, :br_lat, :tr_lat, :bl_lat, 
	# :tl_lon, :br_lon, :tr_lon, :bl_lon, :cloud_cover, :feed_item_id

  has_one :area_update_download_task
  belongs_to :feed_item
  has_many :intersections

  @@min_cloud_cover = 40	# must be below this
  # Getters
  def min_cloud_cover
  	@@min_cloud_cover
  end

  # sets required information about an image except 
    # the image url because it's not on the details page.
    # must call save after. Must pass in the feed item creating it.
    # returns if the system should take it into account or discard it.
  def init attrs
    self.attributes=attrs
    #band3_url=image_url
    #band4_url=image_url
    return can_use?
  end
  def handle
    #puts au.image_url
    is_int=false
    Area.all.each do |a|
      is_int=true if find_intersection a
    end
    if is_int #if there was one or more intersections
      save
      create_download_job # uses the image downloader
    end
  end

  # cloud cover requirements.
  def can_use?
  	if cloud_cover.to_i<=@@min_cloud_cover
  		true
  	end
  end
  
  # This creates an intersection if needed.
  def find_intersection area
    logger.debug "Checking for Intersection:"
    a = area.get_points
    au = get_points
    logger.debug "Area: #{a}"
    logger.debug "Area Update: #{au}"
    # My Lower right
    au_lr = Hash[:x, au[:x] + au[:width], :y, au[:y] + au[:height]]
    # Area lower right
    a_lr = Hash[:x, a[:x] + a[:width], :y, a[:y] + a[:height]]
    # true if collision
    if ( ! (
      (a[:x] > au_lr[:x]) ||
      (au[:x] > a_lr[:x]) ||
      (a[:y] > au_lr[:y]) ||
      (au[:y] > a_lr[:y]) )
        )
      intersect = Hash[:x, 0, :y, 0, :w, 0, :h, 0]
      intersect[:x] = [a[:x],au[:x]].max
      intersect[:y] = [a[:y],au[:y]].max
      intersect[:w] = [a_lr[:x],au_lr[:x]].min - intersect[:x]
      intersect[:h] = [a_lr[:y],au_lr[:y]].min - intersect[:y]

      i=intersections.new intersect
      i.area=area
      i.save
      logger.debug " New with: #{intersect}."
      true
    else
      logger.debug " None."
      false
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
  	Hash[:y, y, :height, allLat.max - y, :x, x, :width, allLon.max - x]
  end

  # This method creeate image in the queue with image url that
  	# must be already set
  def create_download_job
  	dl_task = AreaUpdateDownloadTask.new
    # dl_task.image_url = image_url  # not really needed, must discuss
    dl_task.area_update = self
    dl_task.save
  end

end
