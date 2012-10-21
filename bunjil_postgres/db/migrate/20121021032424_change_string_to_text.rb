class ChangeStringToText < ActiveRecord::Migration
  def up
    change_column :area_update_download_tasks, :image_archive_url, :text
    change_column :area_updates, :image_url, :text
    change_column :area_updates, :band3_url, :text
    change_column :area_updates, :band4_url, :text
    change_column :areas, :name, :text
    change_column :delayed_jobs, :locked_by, :text
    change_column :delayed_jobs, :queue, :text
    change_column :feed_items, :scene_id, :text
    change_column :feed_items, :link, :text
    change_column :feeds, :url, :text
    change_column :feeds, :name, :text
    change_column :roles, :name, :text
  end

  def down
    change_column :area_update_download_tasks, :image_archive_url, :string
    change_column :area_updates, :image_url, :string
    change_column :area_updates, :band3_url, :string
    change_column :area_updates, :band4_url, :string
    change_column :areas, :name, :string
    change_column :delayed_jobs, :locked_by, :string
    change_column :delayed_jobs, :queue, :string
    change_column :feed_items, :scene_id, :string
    change_column :feed_items, :link, :string
    change_column :feeds, :url, :string
    change_column :feeds, :name, :string
    change_column :roles, :name, :string
  end
end
