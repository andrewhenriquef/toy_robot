class BoardController < ApplicationController
  def index
    @robot = Robot.first
    @board = @robot.board
  end
end
