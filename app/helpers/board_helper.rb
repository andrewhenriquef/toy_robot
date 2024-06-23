module BoardHelper
  def self.square_color(row, col)
    return 'light' if (row + col).even?

    'dark'
  end

  def render_robot_if_present(robot, row, col)
    if row == robot.axis_y && col == robot.axis_x
      content_tag :div, '', class: "robot #{robot.face}"
    end
  end
end
