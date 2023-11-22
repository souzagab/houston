class CreateSpacecrafts < ActiveRecord::Migration[7.1]
  def change
    create_table :spacecrafts do |t|
      t.references :agency, null: false, foreign_key: true

      t.string :type, null: false, index: true

      t.string :name, null: false
      t.float :speed, null: false, comment: "Speed in km/h"
      t.integer :remaining_fuel, null: false, comment: "Fuel capacity in days"
      t.integer :crew_capacity,  null: false, default: 0

      t.timestamps
    end
  end
end
