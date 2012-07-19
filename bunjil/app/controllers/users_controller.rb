class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.role_id = Role.find_by_name(params[:role])

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
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to root_url, :success => "Your profile has been updated."
    else
      render :action => 'edit'
    end
  end

  def area_select
    @user = current_user
    
    render :area_select_form
  end


end
