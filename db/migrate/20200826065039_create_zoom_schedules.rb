class CreateZoomSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :zoom_schedules do |t|
      t.text :text
      t.string :uuid

      t.timestamps
    end
  end
end
