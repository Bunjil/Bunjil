class CreateAreaUpdates < ActiveRecord::Migration
  def change
    create_table :area_updates do |t|
      t.integer :tl_lat
      t.integer :tl_long
      t.integer :cloud_cover
      t.integer :feed_item_id
      t.string :image_url

      t.timestamps
    end
  end
end
