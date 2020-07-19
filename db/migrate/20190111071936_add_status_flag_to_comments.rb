class AddStatusFlagToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :status_flag, :boolean, default: false
  end
end
