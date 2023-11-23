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
class Payload < ApplicationRecord
  belongs_to :rocket, class_name: "Rocket", foreign_key: :spacecraft_id, inverse_of: :payloads

  enum cargo: {
    fuel: "fuel",
    trash: "trash",
    probe: "probe",
    satellite: "satellite"
  }

  validates :name, presence: true
  validates :weight, presence: true, numericality: { greater_than: 0 }
end
