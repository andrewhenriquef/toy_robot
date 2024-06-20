# frozen_string_literal: true

class Board
  attr_reader :width, :height

  def initialize(width: 5, height: 5)
    @width = width
    @height = height
  end

  def valid_position?(axis_x, axis_y)
    axis_x.between?(0, width - 1) && axis_y.between?(0, height - 1)
  end
end
