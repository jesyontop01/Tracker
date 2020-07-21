class AddTrackIdToDocuments < ActiveRecord::Migration[5.2]
  def change
    add_column :documents, :trackID, :string
  end
end
