class Area < ActiveRecord::Base

  # Return a rectangle with no rotation that encapsulates all corners.
  def get_points
  	y = self[:top_lat]
  	x = self[:left_lon]
  	Hash[:y, y, :h, self[:height], :x, x, :w, self[:width]]
  end
end
