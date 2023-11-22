# == Schema Information
#
# Table name: spacecrafts
#
#  id                                    :bigint           not null, primary key
#  crew_capacity                         :integer          default(0), not null
#  name                                  :string           not null
#  remaining_fuel(Fuel capacity in days) :integer          not null
#  speed(Speed in km/h)                  :float            not null
#  type                                  :string           not null
#  created_at                            :datetime         not null
#  updated_at                            :datetime         not null
#  agency_id                             :bigint           not null
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
  factory :space_bus, parent: :spacecraft do
    type { "SpaceBus" }
  end
end
