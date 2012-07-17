class AddAllCornersToAreaUpdate < ActiveRecord::Migration
  def change
  	remove_column :area_updates, :tl_lat
  	remove_column :area_updates, :tl_long
  	add_column :area_updates, :tr_lat, :string
  	add_column :area_updates, :tr_lon, :string
  	add_column :area_updates, :tl_lon, :string
  	add_column :area_updates, :tl_lat, :string
  	add_column :area_updates, :br_lat, :string
  	add_column :area_updates, :br_lon, :string
  	add_column :area_updates, :bl_lat, :string
  	add_column :area_updates, :bl_lon, :string
  end
end
