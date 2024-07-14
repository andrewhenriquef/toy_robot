class RobotCommandService
  def initialize(robot)
    @robot = robot
  end

  def execute(command)
    sanitized_command = command.chomp.strip.upcase

    return if robot_placed_or_placing?(@robot, sanitized_command)

    case sanitized_command
    when 'MOVE' then @robot.move
    when 'LEFT' then @robot.turn_left
    when 'RIGHT' then @robot.turn_right
    when 'REPORT' then @robot.report
    when 'RESET' then @robot.placed = false
    when /PLACE (\d),(\d),(.+)/
      @robot.place(
        axis_x: Regexp.last_match(1).to_i,
        axis_y: Regexp.last_match(2).to_i,
        face: Regexp.last_match(3)
      )
    end

    @robot.save!
  end

  private

  def robot_placed_or_placing?(robot, command)
    robot.unplaced? && command_didnt_start_with_place?(command)
  end

  def command_didnt_start_with_place?(command)
    !command.start_with?('PLACE')
  end
end
