class RobotsController < ApplicationController
  def update
    robot = Robot.find(allowed_params[:id])

    service = RobotCommandService.new(robot)
    service.execute(allowed_params[:command])

    render json: robot
  end

  def allowed_params
    params
      .permit(:command, :id)
      .to_h
  end
end
