# == Schema Information
#
# Table name: missions
#
#  id                         :bigint           not null, primary key
#  description                :text             default(""), not null
#  duration(Duration in days) :integer          not null
#  spacecraft_type            :string           not null
#  start_date                 :datetime         not null
#  status                     :enum             default("scheduled"), not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  planet_id                  :bigint           not null
#  spacecraft_id              :bigint           not null
#
# Indexes
#
#  index_missions_on_planet_id   (planet_id)
#  index_missions_on_spacecraft  (spacecraft_type,spacecraft_id)
#  index_missions_on_status      (status)
#
# Foreign Keys
#
#  fk_rails_...  (planet_id => planets.id)
#
FactoryBot.define do
  factory :mission do
    planet
    spacecraft { create(%i[rocket space_bus ufo].sample) }

    start_date { Faker::Date.between(from: 1.day.since, to: 1.year.from_now) }
    duration { Faker::Number.between(from: 1, to: 100) }
    description { Faker::Lorem.paragraph }
    status { "scheduled" }

    trait :started do
      status { "started" }
    end

    trait :canceled do
      status { "canceled" }
    end

    trait :failed do
      status { "failed" }
    end

    trait :completed do
      status { "completed" }
    end
  end
end
