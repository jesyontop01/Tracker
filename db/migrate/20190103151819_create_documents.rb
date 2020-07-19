class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.string :series
      t.string :year
      t.string :registrationNo
      t.string :CandidateRange
      t.text :request
      t.text :attachment
      t.string :email
    
      t.timestamps
    end
  end
end
