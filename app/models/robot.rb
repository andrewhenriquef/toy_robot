class Robot < ApplicationRecord
  belongs_to :board

  broadcasts_to ->(robot) { :robots }

  after_update_commit { update_broadcast }

  validates :axis_x, :axis_y, :face, :board, presence: true

  FACE_RULES = {
    'NORTH' => { 'RIGHT' => 'EAST', 'LEFT' => 'WEST' },
    'EAST' => { 'RIGHT' => 'SOUTH', 'LEFT' => 'NORTH' },
    'SOUTH' => { 'RIGHT' => 'WEST', 'LEFT' => 'EAST' },
    'WEST' => { 'RIGHT' => 'NORTH', 'LEFT' => 'SOUTH' }
  }.freeze

  def place(axis_x:, axis_y:, face:)
    raise ArgumentError unless board.valid_position?(axis_x, axis_y)

    self.axis_x = axis_x
    self.axis_y = axis_y
    self.face = face
  end

  def move
    case face
    when 'NORTH' then move_to_north
    when 'EAST' then move_to_east
    when 'SOUTH' then move_to_south
    when 'WEST' then move_to_west
    end
  end

  def turn_left
    self.face = FACE_RULES[face]['LEFT']
  end

  def turn_right
    self.face = FACE_RULES[face]['RIGHT']
  end

  def report
    puts "#{axis_x},#{axis_y},#{face}"
  end

  private

  def move_to_north
    self.axis_y -= 1 if board.valid_position?(axis_x, axis_y - 1)
  end

  def move_to_east
    self.axis_x += 1 if board.valid_position?(axis_x + 1, axis_y)
  end

  def move_to_south
    self.axis_y += 1 if board.valid_position?(axis_x, axis_y + 1)
  end

  def move_to_west
    self.axis_x -= 1 if board.valid_position?(axis_x - 1, axis_y)
  end

  def update_broadcast
    broadcast_replace_to :robots,
                         partial: 'robots/robot',
                         locals: { robot: self }
  end
end
