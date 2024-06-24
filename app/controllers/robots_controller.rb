class RobotsController < ApplicationController
  before_action :robot

  def update
    service = RobotCommandService.new(robot)
    service.execute(allowed_params[:command])

    render json: robot
  end

  def upload_file
    uploaded_file = allowed_params[:file]

    found_first_place = false

    File.open(uploaded_file).each do |line|
      found_first_place = true if line.start_with?('PLACE')

      next unless found_first_place

      service = RobotCommandService.new(robot)
      service.execute(line)
    end

    render json: robot
  end

  private

  def robot
    @robot ||= Robot.find(allowed_params[:id])
  end

  def allowed_params
    params
      .permit(:command, :id, :file)
      .to_h
  end
end
