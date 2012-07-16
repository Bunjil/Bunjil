class CreateAreaUpdateDownloadTasks < ActiveRecord::Migration
  def change
    create_table :area_update_download_tasks do |t|
      t.string :image_url
      t.references :area_update

      t.timestamps
    end
    add_index :area_update_download_tasks, :area_update_id
  end
end
