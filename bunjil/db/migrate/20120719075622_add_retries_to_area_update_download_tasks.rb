class AddRetriesToAreaUpdateDownloadTasks < ActiveRecord::Migration
  def change
    add_column :area_update_download_tasks, :retries, :integer, :default => 0 


  end
end
