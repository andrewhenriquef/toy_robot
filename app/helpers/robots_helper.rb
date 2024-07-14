module RobotsHelper
  def render_robot(robot)
    content_tag :div, '', class: "robot #{robot.face}"
  end

  def robot_in_board_index_position?(robot, row, col)
    row == robot.axis_y && col == robot.axis_x
  end
end
