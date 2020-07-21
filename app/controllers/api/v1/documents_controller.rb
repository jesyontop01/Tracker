 class API::V1::DocumentsController < API::APIController
  #respond_to :json
  def index
    
      
    #@documents = Document.all.order("created_at DESC")

    if params[:trackID].present? 

      sql = <<-SQL 
      SELECT a.series, a.year, a."registrationNo", a."CandidateRange", a.request, a.email, a.created_at,
             b.status, b.reason, b."fromOffice" as "Dispatching Office", c.office_name as "Receiving Office", 
             b.status_flag as "Process Completed?", b.created_at as "Dispatched IN Date", 
             b.updated_at as "Dispatched OUT Date"
      FROM documents As a
      inner join comments As b
      on a.id = b.document_id
      inner join offices as c
      on c.id = b.office_id
      where a."trackID" = '#{params[:trackID]}'
      SQL

      @document = ActiveRecord::Base.connection.exec_query(sql)
      render json: {status: 'SUCCESS', message: 'Loaded @documents', data: @document}, status: :ok
    else

      @user=User.find_by(:id => params[:id])
      @documents = Document.find_by(:email => params[:email])
      render json: {status: 'SUCCESS', message: 'Loaded @documents', data: @documents}, status: :ok
    end
        
       

        
  	end


  def show
    
        if params[:id].present? 

          sql = <<-SQL 
          SELECT a.series, a.year, a."registrationNo", a."CandidateRange", a.request, a.email, a.created_at,
          b.status, b.reason, b."fromOffice" as "Dispatching Office", c.office_name as "Receiving Office", 
          b.status_flag as "Process Completed?", b.created_at as "Dispatched IN Date", 
          b.updated_at as "Dispatched OUT Date"
          FROM documents As a
          inner join comments As b
          on a.id = b.document_id
          inner join offices as c
          on c.id = b.office_id
          where a.id = '#{params[:id]}'
          SQL
 
          @document = ActiveRecord::Base.connection.exec_query(sql)

        end
    
      render json: {status: 'SUCCESS', message: 'Loaded @document', data: @document}, status: :ok
    end

	private

	def document_params
      params.require(:document).permit(:series, :year, :registrationNo, :CandidateRange, :request, :attachment, :email, :trackID)
    end
end