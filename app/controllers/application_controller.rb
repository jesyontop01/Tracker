class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #respond_to :json
  before_action :authenticate_with_token
  before_action :authenticate_user!

   before_action :configure_permitted_parameters, if: :devise_controller?

   private
   def authenticate_with_token
   	if params[:api_token] && params[:email]
   		user = User.find_by_api_token(params[:api_token])
          if user.email == params[:email]
            sign_in(user)
          end
   		#sign_in(user)
   	end
   end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:fullName,:office_id,:email, :password ])
    devise_parameter_sanitizer.permit(:account_update, keys: [:fullName,:office_id,:email, :password, :current_password])
  end 
end
