class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :document, foreign_key: true
      t.text :status, :default => 'Posted'
      t.text :reason, :default => 'Newly Posted'
      t.string :fromOffice
      t.references :office, foreign_key: true

      t.timestamps
    end
  end
end
