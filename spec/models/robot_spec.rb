require './app/models/board'
require './app/models/robot'

RSpec.describe Robot do
  let(:board) { Board.new(width: 5, height: 5) }
  subject(:robot) { Robot.new(board) }

  context 'when there is no board provided' do
    it 'raises an error' do
      expect { Robot.new }
        .to raise_error ArgumentError
    end
  end

  describe '.place' do
    context 'when the position is invalid' do
      it 'does not place the robot on the board' do
        expect { robot.place(axis_x: 6, axis_y: 6, face: 'NORTH') }
          .to raise_error ArgumentError
      end
    end

    it 'places the robot on the valid position and orientation' do
      robot.place(axis_x: 1, axis_y: 2, face: 'NORTH')
      expect(robot.instance_variable_get(:@axis_x)).to eq 1
      expect(robot.instance_variable_get(:@axis_y)).to eq 2
      expect(robot.instance_variable_get(:@face)).to eq 'NORTH'
    end
  end

  describe '.move' do
    context 'when the following moving position is invalid' do
      it 'doesn\'t move the rebot' do
        robot.place(axis_x: 0, axis_y: 0, face: 'NORTH')

        robot.move
        expect(robot.instance_variable_get(:@axis_x)).to eq 0
        expect(robot.instance_variable_get(:@axis_y)).to eq 0
        expect(robot.instance_variable_get(:@face)).to eq 'NORTH'
      end
    end

    context 'when the following moving position is valid' do
      it 'moves the robot' do
        robot.place(axis_x: 0, axis_y: 0, face: 'SOUTH')

        robot.move
        expect(robot.instance_variable_get(:@axis_x)).to eq 0
        expect(robot.instance_variable_get(:@axis_y)).to eq 1
        expect(robot.instance_variable_get(:@face)).to eq 'SOUTH'
      end
    end
  end

  describe '.left' do
    it 'changes the robot\'s direction to the left' do
      robot.place(axis_x: 0, axis_y: 0, face: 'NORTH')

      robot.left
      expect(robot.instance_variable_get(:@face)).to eq 'WEST'
      robot.left
      expect(robot.instance_variable_get(:@face)).to eq 'SOUTH'
      robot.left
      expect(robot.instance_variable_get(:@face)).to eq 'EAST'
    end
  end

  describe '.right' do
    it 'changes the robot\'s direction to the left' do
      robot.place(axis_x: 0, axis_y: 0, face: 'NORTH')

      robot.right
      expect(robot.instance_variable_get(:@face)).to eq 'EAST'
      robot.right
      expect(robot.instance_variable_get(:@face)).to eq 'SOUTH'
      robot.right
      expect(robot.instance_variable_get(:@face)).to eq 'WEST'
    end
  end

  describe '#report' do
    it 'outputs the current position and direction of the robot' do
      robot.place(axis_x: 1, axis_y: 1, face: 'SOUTH')

      expect { robot.report }
        .to output("1,1,SOUTH\n").to_stdout
    end
  end
end
