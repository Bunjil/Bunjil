class RenameImageUrlFromAreaUpdateDownloadTaskToImageId < ActiveRecord::Migration
  def change
  	rename_column :area_update_download_tasks, :image_url_band_3, :image_archive_url 
  end
end
