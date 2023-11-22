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
# STI model for spacecrafts
class Spacecraft < ApplicationRecord
  belongs_to :agency

  validates :type, presence: true
  validates :name, presence: true
  validates :speed, presence: true
end
