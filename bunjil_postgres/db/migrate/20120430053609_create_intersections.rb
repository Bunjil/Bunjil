class CreateIntersections < ActiveRecord::Migration
  def change
    create_table :intersections do |t|
      t.boolean :reported
      t.integer :area_id
      t.integer :area_updated_id

      t.timestamps
    end
  end
end
