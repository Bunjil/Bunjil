class Volunteer < User

	validates_uniqueness_of :email_address

end
