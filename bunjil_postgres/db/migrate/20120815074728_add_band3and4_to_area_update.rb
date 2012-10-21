class AddBand3and4ToAreaUpdate < ActiveRecord::Migration
  def change
   	add_column :area_updates, :band3_url, :string
  	add_column :area_updates, :band4_url, :string
  end
end
