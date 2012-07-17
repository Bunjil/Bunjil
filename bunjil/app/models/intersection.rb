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
