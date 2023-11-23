# == Schema Information
#
# Table name: payloads
#
#  id                                    :bigint           not null, primary key
#  cargo                                 :enum             not null
#  description                           :text             default(""), not null
#  name                                  :string           not null
#  spacecraft_type                       :string           not null
#  weight(Cargo weight in Tons (1000kg)) :integer          not null
#  created_at                            :datetime         not null
#  updated_at                            :datetime         not null
#  spacecraft_id                         :bigint           not null
#
# Indexes
#
#  index_payloads_on_cargo       (cargo)
#  index_payloads_on_spacecraft  (spacecraft_type,spacecraft_id)
#
FactoryBot.define do
  factory :payload do
    rocket

    fuel

    name { Faker::Space.moon }
    weight { Faker::Number.between(from: 1, to: 1000) }
    description { Faker::Lorem.paragraph }

    trait :fuel do
      cargo { "fuel" }
    end

    trait :trash do
      cargo { "trash" }
    end

    trait :probe do
      cargo { "probe" }
    end

    trait :satellite do
      cargo { "satellite" }
    end
  end
end
