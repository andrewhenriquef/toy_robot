class BoardsController < ApplicationController
  def index
    @board = Board.includes(:robot).first
    @robot = @board.robot
  end
end
