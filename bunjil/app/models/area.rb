class Area < ActiveRecord::Base

  has_many :intersections
  has_many :area_updates, :through => :intersections

  has_one :subscriber, :class_name => "User"

  def latest_image_url
  	area_updates.first.try(:image_url)
  end

  # Return a rectangle with no rotation that encapsulates all corners.
  def get_points
    y = self[:top_lat]
    x = self[:left_lon]
    Hash[:y, y, :h, self[:height], :x, x, :w, self[:width]]
  end
end
