class API::APIController < ActionController::Base
    #class Api::ApiController < ActionController::Base
    # Authentication and functionality common to all API endpoint controllers.

    #before_action :authenticate_with_token
  

  

  private
  def authenticate_with_token
      if params[:api_token] && params[:email]
        #   authenticate_or_request_with_http_token do |token, options|
        #     @user = User.where(api_token: params[:api_token]).first
        #   end
  		user = User.find_by_api_token(params[:api_token])
         if user.email == params[:email]
           sign_in(user)
         end
  		#sign_in(user)
  	end
  end
end
