class AreasController < ApplicationController

  def create
    if current_user.is_subscriber?
    	area = Area.new
    	area.attributes = params[:area]
    	if area.save
    		current_user.area = area
    		current_user.save
        flash[:success] = "Area created successfully!"
    	else
        @area.errors.full_messages.each do |msg|
        if flash[:alert].nil?
          flash[:alert] = msg + "|"
        else
          flash[:alert] << msg + "|"
        end
      end
    else
      flash[:alert] = "Only Subscribers can create areas, Volunteers should subscribe to an existing area."
    end

    redirect_to '/'
  end

end