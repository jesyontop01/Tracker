class AddAttributesToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :fullName, :string
    add_reference :users, :office, foreign_key: true
  end
end
