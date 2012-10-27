=begin
An intersection stores the coordinates where an Area Update and Area intersect.
=end
# == Schema Information
#
# Table name: intersections
#
#  id             :integer          not null, primary key
#  reported       :boolean
#  area_id        :integer
#  area_update_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  x              :integer
#  y              :integer
#  w              :integer
#  h              :integer
#

class Intersection < ActiveRecord::Base
  
  belongs_to :area_update
  belongs_to :area
  belongs_to :user # this is it's volunteer

  after_initialize :init

  def init
    self.reported = false if reported.nil?
    #logger.debug "INIT"
  end

  def is_reported?
    reported.nil?
  end
end
