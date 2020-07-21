class UsersController < ApplicationController
 def index
  	@users= User.all.order("created_at DESC")
  end

  def show
    # if params[:id].present?
     @user = User.find_by(:id => params[:id])# ||  User.find_by(:email => params[:email]) || User.friendly.find(params[:id])
    # #@user = User.friendly.find(params[:id])
    # else
    #   @user = User.friendly.find(params[:id])
    # end

    if current_user.office.office_name == "Guest"
      @documents = Document.where(:email => current_user.email).order('created_at Desc')
      else
      @comments = Comment.where("office_id = ? AND status_flag = ?" , current_user.office_id , false).order(:created_at => :desc)
    end

  	# if current_user.office.office_name == "Guest"
  	# @documents = Document.where(:email => current_user.email).order('created_at Desc')
    # else
	    #@comments = Comment.where("office_id = ? AND status_flag = ?" , current_user.office_id , false).order(:created_at => :desc)
    #end
  end

  def api_token
    @user=User.find(params[:id])
    respond_to do |format|
      format.json {render :json => @user.api_token, :status => :ok}
      format.html {}
    #render json: {status: 'SUCCESS', message: 'Loaded @user', data: @user}, status: :ok
    #render html: {}
    end
  end
end
