class BoardController < ApplicationController
  def index
    @robot = Robot.includes(:board).first
  end
end
