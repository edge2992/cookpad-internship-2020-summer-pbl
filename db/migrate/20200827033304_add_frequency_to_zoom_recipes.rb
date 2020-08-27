class AddFrequencyToZoomRecipes < ActiveRecord::Migration[6.0]
  def change
    add_column :zoom_recipes, :frequency, :integer
  end
end
