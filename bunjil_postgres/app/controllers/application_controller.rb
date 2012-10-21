class ApplicationController < ActionController::Base
  include ControllerAuthentication
  include SessionsHelper
  protect_from_forgery
end
