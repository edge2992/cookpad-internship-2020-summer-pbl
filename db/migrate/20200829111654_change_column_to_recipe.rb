class ChangeColumnToRecipe < ActiveRecord::Migration[6.0]
  def change
    remove_column :recipes, :title, :string
    add_index :recipes, :url, :unique => true
  end
  
  def up
    change_column :recipes, :url, :string, null: false
  end

  def down
    change_column :recipes, :url, :string
  end

end
