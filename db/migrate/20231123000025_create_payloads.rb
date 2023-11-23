class CreatePayloads < ActiveRecord::Migration[7.1]
  def change
    create_enum :cargo_types, %w[fuel trash probe satellite]

    create_table :payloads do |t|
      t.references :spacecraft, null: false, foreign_key: true

      t.enum :cargo, enum_type: :cargo_types, null: false, index: true

      t.string :name, null: false
      t.float :weight, null: false, comment: "Cargo weight in Tons (1000kg)"

      t.text :description, null: false, limit: 500, default: ""

      t.timestamps
    end
  end
end
