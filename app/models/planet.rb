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
class Planet < ApplicationRecord
  CLOSEST_DISTANCE_TO_EARTH = 41 # Closest planet to Earth is Venus at 41mm (megameters)

  validates :name, presence: true
  validates :distance_to_earth, presence: true
  validates :distance_to_earth, numericality: { greater_than_or_equal_to: CLOSEST_DISTANCE_TO_EARTH }
end
