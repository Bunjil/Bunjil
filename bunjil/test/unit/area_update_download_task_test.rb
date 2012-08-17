# == Schema Information
#
# Table name: area_update_download_tasks
#
#  id               :integer          not null, primary key
#  image_url_band_3 :string(255)
#  area_update_id   :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  retries          :integer          default(0)
#  image_url_band_4 :string(255)
#

require 'test_helper'

class AreaUpdateDownloadTaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
