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
class Spacecraft < ApplicationRecord
  TYPES = %w[Rocket SpaceBus UFO].freeze

  belongs_to :agency

  has_many :missions, inverse_of: :spacecraft, dependent: :restrict_with_error
  has_many :payloads, inverse_of: :spacecraft, dependent: :destroy

  validates :type, presence: true
  validates :type, inclusion: { in: TYPES }
  validates :name, presence: true
  validates :speed, presence: true
  validates :remaining_fuel, presence: true
end
