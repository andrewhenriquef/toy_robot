class RobotsController < ApplicationController
  def update
    robot = Robot.find(allowed_params[:id])

    robot.process_command(allowed_params[:command])
    robot.save!

    render json: robot
  end

  def allowed_params
    params
      .permit(:command, :id)
      .to_h
  end
end
