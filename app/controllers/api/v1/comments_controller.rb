class API::V1::CommentsController < API::APIController
  #respond_to :json
 # before_action :authenticate_user!, except:[:index]
 before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index

      @document = Document.find(params[:document_id])
      @comments = @document.comments.all.order('created_at Desc')
 
    render json: {status: 'SUCCESS', message: 'Loaded @comments', data: @comments}, status: :ok
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @document = Document.find(params[:document_id])
      @comment = @document.comments.find(params[:id])
      render json: {status: 'SUCCESS', message: 'Loaded @comment', data: @comment}, status: :ok
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:document_id, :status, :reason, :fromOffice, :office_id, :status_flag)
    end
end
