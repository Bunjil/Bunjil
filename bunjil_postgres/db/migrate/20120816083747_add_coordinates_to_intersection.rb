class AddCoordinatesToIntersection < ActiveRecord::Migration
  def change
   	add_column :intersections, :x, :integer
  	add_column :intersections, :y, :integer
   	add_column :intersections, :w, :integer
  	add_column :intersections, :h, :integer
  end
end
