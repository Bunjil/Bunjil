# == Schema Information
#
# Table name: area_update_download_tasks
#
#  id             :integer          not null, primary key
#  image_url      :string(255) # I don't think we need this anymore? it's in the Area U
#  area_update_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  retries        :integer          default(0)
#

class AreaUpdateDownloadTask < ActiveRecord::Base
  belongs_to :area_update

  def band3_url
  	area_update.band3_url
  end
  def band4_url
  	area_update.band4_url
  end
end
