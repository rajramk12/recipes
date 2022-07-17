class CreateCommentsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :comments_tables do |t|
      t.text :description
      t.integer :chef_id
      t.integer :recipe_id
      t.timestamps
    end
  end
end
