class CreateRoles < ActiveRecord::Migration
  def up
  	create_table :roles do |t|
  		t.string :name
  	end

  	Role.create!( :name => "volunteer" )
  	Role.create!( :name => "subscriber" )
  end

  def down
  	drop_table :roles
  end
end
