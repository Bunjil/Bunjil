class FeedItem < ActiveRecord::Base
	validates_uniqueness_of :title

  # Returns the working url
  def get_formatted_url
  	# remove 5 characters after each &
  	link.gsub("&#x26;","&")
  end

end
