class SpacecraftDepartureJob < ApplicationJob
  queue_as :spacecraft_departures

  def perform(mission)
    return unless mission.scheduled?

    Rails.logger.info("Mission##{mission.id}: Departing...")
    mission.started!
  end
end
