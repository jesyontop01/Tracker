class Document < ApplicationRecord
  has_many :statuses
  has_many :comments, dependent: :destroy

 #before_save :save_default_value_on_create, :if => :new_record?

  private

  def save_default_value_on_create
  	
  		if @document.series =='MJ' 
  			@document.office_id = 1
  			@document.action = 'Posted'
  			@document.reason = 'Posted'
  		
  	    elsif
  		 @document.series =='ND' 
  			@document.office_id = 2
  			@document.action = 'Posted'
  			@document.reason = 'Posted'
  		end
  	end

end
