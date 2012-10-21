class CreateFeedItems < ActiveRecord::Migration
  def change
    create_table :feed_items do |t|
      t.string :title
      t.integer :feed_id

      t.timestamps
    end
  end
end
