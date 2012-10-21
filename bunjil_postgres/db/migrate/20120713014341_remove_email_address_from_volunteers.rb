class RemoveEmailAddressFromVolunteers < ActiveRecord::Migration
  def up
  	remove_column :volunteers, :email_address
  end
end
