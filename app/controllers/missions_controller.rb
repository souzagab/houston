class MissionsController < ApplicationController
  before_action :find_mission, only: %i[show update destroy]

  # GET /missions
  def index
    @missions = Mission.all

    render json: @missions
  end

  # GET /missions/1
  def show
    render json: @mission
  end

  # POST /missions
  def create
    @mission = Mission.new(mission_params)

    if @mission.save
      render json: @mission, status: :created, location: @mission
    else
      render json: @mission.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /missions/1
  def update
    if @mission.update(mission_params)
      render json: @mission
    else
      render json: @mission.errors, status: :unprocessable_entity
    end
  end

  # DELETE /missions/1
  def destroy
    @mission.destroy!
  end

  private

  def find_mission
    @mission = Mission.find(params[:id])
  end

  def mission_params
    params.permit(:planet_id, :spacecraft_id, :start_date, :duration, :description, :status)
  end
end
