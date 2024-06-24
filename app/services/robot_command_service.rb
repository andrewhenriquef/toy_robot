class RobotCommandService
  def initialize(robot)
    @robot = robot
  end

  def execute(command)
    sanitized_command = command.chomp.strip.upcase

    case sanitized_command
    when 'MOVE' then @robot.move
    when 'LEFT' then @robot.turn_left
    when 'RIGHT' then @robot.turn_right
    when 'REPORT' then @robot.report
    when /PLACE (\d),(\d),(.+)/
      @robot.place(
        axis_x: Regexp.last_match(1).to_i,
        axis_y: Regexp.last_match(2).to_i,
        face: Regexp.last_match(3)
      )
    end

    @robot.save!
  end
end
