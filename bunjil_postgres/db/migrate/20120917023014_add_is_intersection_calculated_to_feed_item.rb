class AddIsIntersectionCalculatedToFeedItem < ActiveRecord::Migration
  def change
    add_column :feed_items, :is_intersection_checked, :boolean
  end
end
