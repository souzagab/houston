# == Schema Information
#
# Table name: spacecrafts
#
#  id                   :bigint           not null, primary key
#  name                 :string           not null
#  speed(Speed in km/h) :float            not null
#  type                 :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  agency_id            :bigint           not null
#
# Indexes
#
#  index_spacecrafts_on_agency_id  (agency_id)
#  index_spacecrafts_on_type       (type)
#
# Foreign Keys
#
#  fk_rails_...  (agency_id => agencies.id)
#
FactoryBot.define do
  factory :spacecraft do
    agency

    type { nil } # Ensure the factory have a type

    name { Faker::Space.nasa_space_craft }
    speed { Faker::Number.decimal(l_digits: 2, r_digits: 3, min_value: 40_000) }
  end
end
