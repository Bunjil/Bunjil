# == Schema Information
#
# Table name: feeds
#
#  id         :integer          not null, primary key
#  url        :string(255)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null

# LandSat7 url: "http://landsat.usgs.gov/Landsat7.rss"

class Feed < ActiveRecord::Base

	validates_uniqueness_of :name

end
