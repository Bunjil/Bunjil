class RemoveImageUrlBand4FromAreaUpdateDownloadTask < ActiveRecord::Migration
  def up
    remove_column :area_update_download_tasks, :image_url_band_4
      end

  def down
    add_column :area_update_download_tasks, :image_url_band_4, :string
  end
end
