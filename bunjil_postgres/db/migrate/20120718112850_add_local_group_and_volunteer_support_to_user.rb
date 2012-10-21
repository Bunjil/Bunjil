class AddLocalGroupAndVolunteerSupportToUser < ActiveRecord::Migration
  def change
  	add_column :users, :area_id, :integer, :index => true
  	add_column :users, :role_id, :integer
  	add_column :users, :description, :string
  end
end
