class Report < ActiveRecord::Base
	belongs_to :intersection
	belongs_to :user
	serialize :location, Array
end
