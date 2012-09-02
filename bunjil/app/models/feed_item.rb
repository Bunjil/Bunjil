# == Schema Information
#
# Table name: feed_items
#
#  id         :integer          not null, primary key
#  scene_id   :string(255)
#  link       :string(255)
#  feed_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FeedItem < ActiveRecord::Base
  validates_uniqueness_of :scene_id

  # Returns the working url
  def get_formatted_url
  	# remove 5 characters after each &
  	link.gsub("&#x26;","&")
  end

end
