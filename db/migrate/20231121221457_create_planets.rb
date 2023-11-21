class CreatePlanets < ActiveRecord::Migration[7.1]
  def change
    create_table :planets do |t|
      t.string :name, null: false
      t.integer :distance_to_earth, null: false, comment: "Distance in megameters (1mm = 1,000,000km)"

      t.timestamps
    end
  end
end
