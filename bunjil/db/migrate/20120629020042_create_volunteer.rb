class CreateVolunteer < ActiveRecord::Migration
  def up
  	create_table :volunteers do |t|
  		t.integer :user_id
  		t.integer :area_id
  		t.string  :email_address
  	end
  end

  def down
  	drop_table :volunteers
  end
end
