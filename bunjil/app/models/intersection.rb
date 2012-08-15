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
#

class Intersection < ActiveRecord::Base
  
  belongs_to :area_update
  belongs_to :area

  after_initialize :init

  def init
    reported = false
  end

  def is_reported?
    reported.nil?
  end
end
