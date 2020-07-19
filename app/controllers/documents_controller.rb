class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.all.order("created_at DESC")
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @user=User.find_by(:id => params[:id])
      @documents = Document.where(:email => current_user.email)
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)

    respond_to do |format|
      if @document.save 
        #Status.create(document_id: @document.id, arrivalFrom: current_user.office.office_name)
        #@document = Document.find(params[:document_id])
       #@comment =@document.comments.create(document_id: @document.id, fromOffice: current_user.office.office_name)
        if @document.series == "MJ" || @document.series=="SC"
           #@comment.office_id = 1
            Comment.create(document_id: @document.id, fromOffice: current_user.office.office_name, office_id: 1)
       else
         #@comment.office_id = 2 
         Comment.create(document_id: @document.id, fromOffice: current_user.office.office_name, office_id: 2)     
        end

        #Comment.create(document_id: @document.id, fromOffice: current_user.office.office_name)
        #status_onCreate_document
        format.html { redirect_to @document, notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id]) 
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:series, :year, :registrationNo, :CandidateRange, :request, :attachment, :email)
    end

    def comment_params
       params.require(:comment).permit(:document_id, :status, :reason, :fromOffice, :office_id, :status_flag)
    end

    def status_params
      params.require(:status).permit(:document_id, :action, :reason, :arrivalFrom, :postedTo)
    end

    def self.status_onCreate_document

      Status.create(document_id: @document.id, action: status.action, reason:status.reason, arrivalFrom: current_user.office.office_name,
        postedTo: status.postedTo)
    @status = Status.new(status_params)

    respond_to do |format|
      if @status.save
        format.html { redirect_to @status, notice: 'Status was successfully created.' }
        format.json { render :show, status: :created, location: @status }
      else
        format.html { render :new }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end
end
