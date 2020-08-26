class CreateZoomRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :zoom_recipes do |t|
      t.belongs_to :zoom_schedules
      t.belongs_to :recipe
      
      t.timestamps
    end
  end
end
