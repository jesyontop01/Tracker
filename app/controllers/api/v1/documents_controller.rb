 class API::V1::DocumentsController < API::APIController
  #respond_to :json
	def index
    @user=User.find_by(:id => params[:id])
      @documents = Document.find_by(:email => params[:email])
    #@documents = Document.all.order("created_at DESC")
    render json: {status: 'SUCCESS', message: 'Loaded @documents', data: @documents}, status: :ok
  	end


	def show
     # @document = Document.find(params[:id]) 
                          sql = <<-SQL 
                                      SELECT a.series, a.year, a."registrationNo", a."CandidateRange", a.request, a.email, a.created_at,
                                             b.status, b.reason, b."fromOffice", c.office_name, b.status_flag
                                      FROM documents As a
                                      inner join comments As b
                                      on a.id = b.document_id
                                      inner join offices as c
                                      on c.id = b.office_id
                                      where a.id = '#{params[:id]}'
                                      SQL

                                    @document = ActiveRecord::Base.connection.exec_query(sql)
           
    
      render json: {status: 'SUCCESS', message: 'Loaded @document', data: @document}, status: :ok
    end

	private

	def document_params
      params.require(:document).permit(:series, :year, :registrationNo, :CandidateRange, :request, :attachment, :email)
    end
end