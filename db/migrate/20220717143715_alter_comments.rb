class AlterComments < ActiveRecord::Migration[7.0]
  def change
    rename_table :comments_tables, :comments
  end
end
