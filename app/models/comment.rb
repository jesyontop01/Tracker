class Comment < ApplicationRecord
  belongs_to :document
  belongs_to :office

  validates :fromOffice, presence: true
end
