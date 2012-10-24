class AddUserToIntersection < ActiveRecord::Migration
  def change 
    add_column :intersections, :user_id, :integer
  end
end
