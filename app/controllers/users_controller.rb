class UsersController < ApplicationController
 def index
  	@users= User.all.order("created_at DESC")
  end

  def show
  	@user=User.find_by(:id => params[:id])
  	if current_user.office.office_name == "Guest"
  	@documents = Document.where(:email => current_user.email).order('created_at Desc')
    else
	#@comments = Comment.where(:office_id => current_user.office_id && status_flag: false).order(:created_at => :desc)
	#Client.where("orders_count = ? AND locked = ?", params[:orders], false)
	@comments = Comment.where("office_id = ? AND status_flag = ?" , current_user.office_id , false).order(:created_at => :desc)
	#@documents = Document.where(:id  => @comments.id)
    end
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
