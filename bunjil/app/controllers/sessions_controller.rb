class SessionsController < ApplicationController
before_filter :logout_required, :except => [:destroy]

  def new
  end

  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      sign_in(user)
      session[:user_id] = user.id

      redirect_to root_url, :flash => { :success => "Logged in successfully." }
    else
      flash[:alert] = "Invalid login or password."
      render :action => 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    current_user=nil
    redirect_to root_url, :flash => { :success =>"You have been logged out."}
  end
end
