# == Schema Information
#
# Table name: missions
#
#  id                         :bigint           not null, primary key
#  description                :text             default(""), not null
#  duration(Duration in days) :integer          not null
#  start_date                 :datetime         not null
#  status                     :enum             default("scheduled"), not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  planet_id                  :bigint           not null
#  spacecraft_id              :bigint           not null
#
# Indexes
#
#  index_missions_on_planet_id      (planet_id)
#  index_missions_on_spacecraft_id  (spacecraft_id)
#  index_missions_on_status         (status)
#
# Foreign Keys
#
#  fk_rails_...  (planet_id => planets.id)
#  fk_rails_...  (spacecraft_id => spacecrafts.id)
#
FactoryBot.define do
  factory :mission do
    planet

    spacecraft factory: %i[rocket space_bus ufo].sample

    scheduled

    start_date { Faker::Date.between(from: 1.day.since, to: 1.year.from_now) }
    duration { Faker::Number.between(from: 1, to: 100) }
    description { Faker::Lorem.paragraph }


    trait :scheduled do
      status { "scheduled" }
    end

    trait :started do
      skip_validation

      status { "started" }
    end

    trait :canceled do
      skip_validation

      status { "canceled" }
    end

    trait :failed do
      skip_validation

      status { "failed" }
    end

    trait :completed do
      skip_validation

      status { "completed" }
    end

    trait :skip_validation do
      to_create { |instance| instance.save(validate: false) }
    end
  end
end
