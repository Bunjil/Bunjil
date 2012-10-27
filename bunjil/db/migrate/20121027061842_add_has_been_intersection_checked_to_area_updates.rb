class AddHasBeenIntersectionCheckedToAreaUpdates < ActiveRecord::Migration
  def change
    add_column "area_updates", :has_been_intersection_checked, :bool
  end
end
