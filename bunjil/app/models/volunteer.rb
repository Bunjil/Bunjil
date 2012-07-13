class Volunteer < ActiveRecord::Base

  belongs_to :user

  def method_missing(m, *args, &block)
    if (User.new.respond_to?(m, *args, &block))
      user ||= User.new
      return user.send(m, *args, &block)
    end

    super(m, *args, &block)
  end

end