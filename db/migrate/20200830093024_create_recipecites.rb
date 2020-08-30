class CreateRecipecites < ActiveRecord::Migration[6.0]
  def change
    create_table :recipecites do |t|
      t.string :host

      t.timestamps

      t.index :host, unique: true
    end
  end
end
