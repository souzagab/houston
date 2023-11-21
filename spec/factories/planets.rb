# == Schema Information
#
# Table name: planets
#
#  id                                                            :bigint           not null, primary key
#  distance_to_earth(Distance in megameters (1mm = 1,000,000km)) :integer          not null
#  name                                                          :string           not null
#  created_at                                                    :datetime         not null
#  updated_at                                                    :datetime         not null
#
FactoryBot.define do
  factory :planet do
    name { Faker::Space.planet }
    distance_to_earth { Faker::Number.between(from: Planet::CLOSEST_DISTANCE_TO_EARTH, to: 1_000_000_000_000) }
  end
end
