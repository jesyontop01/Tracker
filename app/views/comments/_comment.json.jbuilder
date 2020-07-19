json.extract! comment, :id, :document_id, :status, :reason, :fromOffice, :toOffice, :created_at, :updated_at
json.url comment_url(comment, format: :json)
