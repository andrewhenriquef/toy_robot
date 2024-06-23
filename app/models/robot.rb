class Robot < ApplicationRecord
  belongs_to :board

  broadcasts_to ->(_robot) { :robots }

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
    send("move_to_#{face.downcase}")
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
    update_to_new_position(axis_y: axis_y - 1)
  end

  def move_to_east
    update_to_new_position(axis_x: axis_x + 1)
  end

  def move_to_south
    update_to_new_position(axis_y: axis_y + 1)
  end

  def move_to_west
    update_to_new_position(axis_x: axis_x - 1)
  end

  def update_to_new_position(axis_x: self.axis_x, axis_y: self.axis_y)
    return unless board.valid_position?(axis_x, axis_y)

    self.axis_x = axis_x
    self.axis_y = axis_y
  end

  def update_broadcast
    broadcast_replace_to :robots,
                         partial: 'robots/robot',
                         locals: { robot: self }
  end
end
