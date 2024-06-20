# frozen_string_literal: true
require 'debug'

class Robot
  FACE_RULES = {
    'NORTH' => { 'RIGHT' => 'EAST', 'LEFT' => 'WEST' },
    'EAST' => { 'RIGHT' => 'SOUTH', 'LEFT' => 'NORTH' },
    'SOUTH' => { 'RIGHT' => 'WEST', 'LEFT' => 'EAST' },
    'WEST' => { 'RIGHT' => 'NORTH', 'LEFT' => 'SOUTH' }
  }.freeze

  def initialize(board)
    @board = board
  end

  def place(axis_x:, axis_y:, face:)
    raise ArgumentError unless @board.valid_position?(axis_x, axis_y)

    @axis_x = axis_x
    @axis_y = axis_y
    @face = face
  end

  def move
    case @face
    when 'NORTH'
      @axis_y -= 1 if @board.valid_position?(@axis_x, @axis_y - 1)
    when 'EAST'
      @axis_x += 1 if @board.valid_position?(@axis_x + 1, @axis_y)
    when 'SOUTH'
      @axis_y += 1 if @board.valid_position?(@axis_x, @axis_y + 1)
    when 'WEST'
      @axis_x -= 1 if @board.valid_position?(@axis_x - 1, @axis_y)
    end
  end

  def left
    @face = FACE_RULES[@face]['LEFT']
  end

  def right
    @face = FACE_RULES[@face]['RIGHT']
  end

  def report
    puts "#{@axis_x},#{@axis_y},#{@face}"
  end
end
