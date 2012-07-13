class VolunteersController < ApplicationController
  before_filter :login_required, :except => [:new, :create]

  def new
    @volunteer = Volunteer.new
  end

  def create
    @volunteer = Volunteer.new(params[:volunteer])
    if @volunteer.save
      session[:user_id] = @volunteer.id
      redirect_to root_url, :notice => "Thank you for signing up! You are now logged in."
    else
      render :action => 'new'
    end
  end

  def edit
    
  end

  def update
    
  end
end
