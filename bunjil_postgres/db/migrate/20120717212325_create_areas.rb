class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.integer :top_lat
      t.integer :left_lon
      t.integer :width
      t.integer :height
      t.timestamps
    end
  end
end
