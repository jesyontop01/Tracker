class StatusesController < ApplicationController

	def index
		
	end

	def new
		@status=Status.new
	end

	def create
		@status=Status.new(status_params)

    respond_to do |format|
      if @status.save
        format.html { redirect_to @document, notice: 'Status was successfully created.' }
        format.json { render :show, status: :created, location: @status }
      else
        format.html { render :new }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
	end

	def edit
		@document=Document.find(params[:id])
		@status=Status.where(@document.id == @status.document_id)
	end

	def update
		respond_to do |format|
      if @status.update(status_params)
        format.html { redirect_to @document, notice: 'Status was successfully updated.' }
        format.json { render :show, status: :ok, location: @status }
      else
        format.html { render :edit }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
		
	end


	private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def status_params
      params.require(:status).permit(:document_id, :action, :reason, :arrivalFrom, :postedTo)
    end
end
