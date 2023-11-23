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

  with_options if: :status_changed_to_started? do
    validate :ensure_status_was_scheduled
  end

  with_options if: :status_changed_to_canceled? do
    validate :ensure_status_was_scheduled_or_started
  end

  with_options if: :status_changed_to_failed? do
    validate :ensure_status_was_started
  end

  private

  def status_changed_to_started?
    status_changed? && started?
  end

  def status_changed_to_canceled?
    status_changed? && canceled?
  end

  def status_changed_to_failed?
    status_changed? && failed?
  end

  def ensure_status_was_scheduled
    errors.add(:status, "can only be changed from scheduled to started") unless status_was == "scheduled"
  end

  def ensure_status_was_started
    errors.add(:status, "can only be changed from started to failed") unless status_was == "started"
  end

  def ensure_status_was_scheduled_or_started
    errors.add(:status, "can only be changed from scheduled or started to canceled") unless %w[scheduled started].include?(status_was)
  end
end
