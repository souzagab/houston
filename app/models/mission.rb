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
class Mission < ApplicationRecord
  belongs_to :planet
  belongs_to :spacecraft, polymorphic: true

  enum status: {
    scheduled: "scheduled",
    started: "started",
    canceled: "canceled",
    failed: "failed",
    completed: "completed"
  }

  validates :start_date, presence: true
  validates :duration, presence: true
  validates :description, presence: true
  validates :status, presence: true
end
