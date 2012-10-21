class AddImageUrlBand4ToAreaUpdateDownloadTasks < ActiveRecord::Migration
  def change
    add_column :area_update_download_tasks, :image_url_band_4, :string
  end
end
