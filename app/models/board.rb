# == Schema Information
#
# Table name: boards
#
#  id         :integer          not null, primary key
#  height     :integer
#  started    :boolean          default(FALSE), not null
#  width      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Board < ApplicationRecord
  has_one :robot

  validates :height, :width, presence: true

  def valid_position?(axis_x, axis_y)
    axis_x.between?(0, width - 1) && axis_y.between?(0, height - 1)
  end
end
