class CreateStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :statuses do |t|
      t.references :document, foreign_key: true
      t.string :action, :default => 'Posted'
      t.text :reason, :default => 'Newly Posted'
      t.string :arrivalFrom
      t.string :postedTo

      t.timestamps
    end
  end
end
