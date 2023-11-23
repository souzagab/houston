class CreateMissions < ActiveRecord::Migration[7.1]
  def change
    create_enum :mission_status, %w[scheduled started canceled failed completed]

    create_table :missions do |t|
      t.references :planet, null: false, foreign_key: true
      t.references :spacecraft, null: false, foreign_key: true

      t.datetime :start_date, null: false
      t.integer :duration, null: false, comment: "Duration in days"
      t.text :description, null: false, default: "", limit: 500
      t.enum :status, enum_type: :mission_status, default: "scheduled", null: false, index: true

      t.timestamps
    end
  end
end
