class RenameTitleToSceneIdForFeedItem < ActiveRecord::Migration
  def change
  	rename_column :feed_items, :title, :scene_id
  end
end
