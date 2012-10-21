class RenameDownloaderImageUrl < ActiveRecord::Migration
  
  def change
  	rename_column :area_update_download_tasks, :image_url, :image_url_band_3  
  end
end
