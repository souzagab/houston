module Spacecrafts
  class MissionsController < ApplicationController
    def index
      spacecraft = Spacecraft.find(params[:spacecraft_id])
      missions = spacecraft.missions

      render json: missions
    end
  end
end
