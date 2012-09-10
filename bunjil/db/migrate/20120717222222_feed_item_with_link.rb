class FeedItemWithLink < ActiveRecord::Migration
  def change
  	add_column :feed_items, :link, :string 
  end
end
