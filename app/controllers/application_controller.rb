class ApplicationController < ActionController::Base

before_action :authenticate_user!,except: [:top, :about]

before_action :configure_permitted_parameters, if: :devise_controller?

def after_sign_in_path_for(resource)
    user_path(resource)
end

def after_sign_out_path_for(resource)
    flash[:notice] = "signed out successfully."
    root_path
end

def create
  @user = User.new(user_params)
  
  if @user.save
    flash[:success] = "Welcome! You have signed up successfully."
    redirect_to user_path(current_user)
  
  else
    render :top
  end
end

protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end
end