module SessionsHelper
	def sign_in(user)
		self.current_user = user
	end
	def current_user=(user)
		@current_user = user
	end
	def signed_in?
		current_user != nil
	end
end
