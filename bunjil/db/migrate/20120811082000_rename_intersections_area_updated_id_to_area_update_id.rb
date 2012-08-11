class RenameIntersectionsAreaUpdatedIdToAreaUpdateId < ActiveRecord::Migration
  def change
  	rename_column :intersections, :area_updated_id, :area_update_id
  end
end
