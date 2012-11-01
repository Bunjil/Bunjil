# == Schema Information
#
# Table name: image_processor_tasks
#
#  id             :integer          not null, primary key
#  area_update_id :integer
#  red            :text
#  near_infrared  :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class ImageProcessorTask < ActiveRecord::Base
  belongs_to :area_update
end
