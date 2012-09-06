class AddLonLatToReport < ActiveRecord::Migration
  def up
    remove_column :reports, :longitude
    remove_column :reports, :latitude
    remove_column :reports, :name
    add_column :reports, :location, :text
    add_column :reports, :intersection_id, :integer
    add_column :reports, :user_id, :integer
  end

  def down
  	remove_column :reports, :user_id, :integer
  	remove_column :reports, :intersection_id
  	remove_column :reports, :location
  	add_column :reports, :name, :string
    add_column :reports, :longitude, :decimal
    add_column :reports, :latitude, :decimal
  end
end
