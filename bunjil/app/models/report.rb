# == Schema Information
#
# Table name: reports
#
#  id              :integer          not null, primary key
#  description     :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  location        :text
#  intersection_id :integer
#  user_id         :integer
#

class Report < ActiveRecord::Base
	belongs_to :intersection
	belongs_to :user
	serialize :location, Array
end
