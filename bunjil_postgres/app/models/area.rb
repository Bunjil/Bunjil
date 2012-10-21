/
An area is a subscribed location in the system.
/
# == Schema Information
#
# Table name: areas
#
#  id          :integer          not null, primary key
#  top_lat     :integer
#  left_lon    :integer
#  width       :integer
#  height      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#  name        :string(255)
#

class Area < ActiveRecord::Base

  has_many :intersections
  has_many :area_updates, :through => :intersections

  has_one :subscriber, :class_name => "User", :conditions => ["\"users\".role_id = (SELECT id FROM roles WHERE name = 'subscriber')"]

  def latest_image_url
  	area_updates.first.try(:image_url)
  end

  # Return a rectangle with no rotation that encapsulates all corners.
  def get_points
    y = self[:top_lat]
    x = self[:left_lon]
    Hash[:y, y, :height, self[:height], :x, x, :width, self[:width]]
  end
end
