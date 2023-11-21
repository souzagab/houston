class CreateSpacecrafts < ActiveRecord::Migration[7.1]
  def change
    create_table :spacecrafts do |t|
      t.references :agency, null: false, foreign_key: true

      t.string :type, null: false, index: true

      t.string :name, null: false
      t.float :speed, null: false, comment: "Speed in km/h"

      t.timestamps
    end
  end
end
