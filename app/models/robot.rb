class Robot < ApplicationRecord
  belongs_to :board

  broadcasts_to ->(robot) { :robots }

  after_update_commit { update_broadcast }

  validates :axis_x, :axis_y, :face, presence: true

  FACE_RULES = {
    'NORTH' => { 'RIGHT' => 'EAST', 'LEFT' => 'WEST' },
    'EAST' => { 'RIGHT' => 'SOUTH', 'LEFT' => 'NORTH' },
    'SOUTH' => { 'RIGHT' => 'WEST', 'LEFT' => 'EAST' },
    'WEST' => { 'RIGHT' => 'NORTH', 'LEFT' => 'SOUTH' }
  }.freeze

  def process_command(command)
    case command.chomp
    when 'MOVE' then move
    when 'LEFT' then left
    when 'RIGHT' then right
    when 'REPORT' then report
    when /PLACE (\d),(\d),(.+)/
      place(
        axis_x: Regexp.last_match(1).to_i,
        axis_y: Regexp.last_match(2).to_i,
        face: Regexp.last_match(3)
      )
    end
  end

  private

  def place(axis_x:, axis_y:, face:)
    raise ArgumentError unless board.valid_position?(axis_x, axis_y)

    self.axis_x = axis_x
    self.axis_y = axis_y
    self.face = face
  end

  def move
    case face
    when 'NORTH'
      self.axis_y -= 1 if board.valid_position?(axis_x, axis_y - 1)
    when 'EAST'
      self.axis_x += 1 if board.valid_position?(axis_x + 1, axis_y)
    when 'SOUTH'
      self.axis_y += 1 if board.valid_position?(axis_x, axis_y + 1)
    when 'WEST'
      self.axis_x -= 1 if board.valid_position?(axis_x - 1, axis_y)
    end
  end

  def left
    self.face = FACE_RULES[face]['LEFT']
  end

  def right
    self.face = FACE_RULES[face]['RIGHT']
  end

  def report
    puts "#{axis_x},#{axis_y},#{face}"
  end

  def update_broadcast
    broadcast_replace_to :robots,
                         partial: 'robots/robot',
                         locals: { robot: self }
  end
end
