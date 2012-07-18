class DropVolunteerTable < ActiveRecord::Migration
  def up
	drop_table :volunteers
  end

  def down
  	create_table :volunteers do |t|
  		t.integer :user_id
  		t.integer :area_id
  		t.string  :email_address
  	end
  end
end
