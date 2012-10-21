class AddNameAndDescriptionForArea < ActiveRecord::Migration
  def change
  	add_column :areas, :description, :text
  	add_column :areas, :name, :string
  end
end
