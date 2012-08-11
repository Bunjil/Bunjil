class AreasController < ApplicationController

  def create
  	area = Area.new
  	area.attributes = params[:area]
  	if area.save
  		current_user.area = area
  		current_user.save
  	end
  end

end