module ApplicationHelper
  def flash_class(level)
    case level
    when :notice then "alert alert-info"
    when :success then "alert alert-success"
    when :error then "alert alert-error"
    when :alert then "alert alert-error"
    end
  end

  # This method is used by the navbar to test if the menu item should be
	# selected. If it should it returns "active".
  def is_current_uri?(string)
	  string == request.env['PATH_INFO'] ? "'active'" : "'inactive'"
  end

end
