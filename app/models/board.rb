class Board < ApplicationRecord
  has_one :robot

  validates :height, :width, presence: true

  def valid_position?(axis_x, axis_y)
    axis_x.between?(0, width - 1) && axis_y.between?(0, height - 1)
  end
end
