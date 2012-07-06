class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, :success => "Thank you for signing up! You are now logged in."
    else
      @messages = "<h3> Invalid Input </h3> <ul>"
      @user.errors.full_messages.each do |msg|
      @messages << "<li>"+msg+"</li>"
      end
      @messages << "</ul>"
      flash[:success] = @messages
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
end
