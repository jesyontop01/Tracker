class API::V1::UsersController < API::APIController
#class Api::v1::UsersController < API::APIController
		#respond_to :json
	  	def index
		  	@users = User.all.order('created_at Desc')
		  	render json: {status: 'SUCCESS', message: 'Loaded @users', data: @users}, status: :ok
		 end

	def show
	  	@user=User.find_by(:id => params[:id])
	  	#current_user.email = @user.email
	  	#if current_user.office_id == 13
	  	#@documents = Document.find_by(:email => params[:email])#.order('created_at Desc')
	  	@documents = Document.where(:email => params[:email])
	    #else
		#@comments = Comment.where(:office_id => current_user.office_id && status_flag: false).order(:created_at => :desc)
		#Client.where("orders_count = ? AND locked = ?", params[:orders], false)
		#@comments = Comment.where("office_id = ? AND status_flag = ?" , current_user.office_id , false).order(:created_at => :desc)
		#@documents = Document.where(:id  => @comments.id)
		#end
		render json: {status: 'SUCCESS', message: 'Loaded @documents', data: @documents}, status: :ok
	end

	private

			def document_params
      params.require(:document).permit(:series, :year, :registrationNo, :CandidateRange, :request, :attachment, :email)
    end
end