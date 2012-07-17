class FeedItemWithLink < ActiveRecord::Migration
  def change
  	drop_table :feed_items 
    create_table :feed_items do |t|
      t.string :title
      t.string :link
      t.integer :feed_id

      t.timestamps
    end
  end
end
