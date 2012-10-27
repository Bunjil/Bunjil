class AddHasBeenIntersectionCheckedToAreaUpdates < ActiveRecord::Migration
  def change
    add_column "area_updates", :has_been_intersection_checked, :boolean, :default => false, :null => false
  end
end
