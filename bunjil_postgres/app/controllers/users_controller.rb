class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.role_id = Role.find_by_name(params[:role]).id

    if @user.save
      session[:user_id] = @user.id
      current_user = @user
      redirect_to root_url, :success => "Thank you for signing up! You are now logged in."
    else
      @user.errors.full_messages.each do |msg|
        if flash[:alert].nil?
          flash[:alert] = msg+"|"
        else
           flash[:alert] << msg+"|"
        end
      end
      
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
    @areas = Area.find :all if @user.is_volunteer?
  end

  def update
    @user = current_user

    if @user.update_attributes(params[:user])
      flash[:notice] = "User profile updated successfully."
      redirect_to root_url
    else
      render :action => 'edit'
    end
  end

  def area_observation
    @user = current_user
    if @user.area.nil?
      redirect_to root_url, :flash => { :alert => "User does not have area" }
    else
      query = Intersection.where(:area_id => @user.area.id).order('created_at DESC')
      intersection = query.first
      last_intersection = query.second
      if !last_intersection || !intersection
        redirect_to root_url, :flash => { :alert => "Could not find a valid intersection for this area" }
      else
        @area_update_old = last_intersection.area_update
        @area_update = intersection.area_update
        @report=Report.new
        @report.intersection = intersection
        @report.user = @user
      end
    end
  end
end
