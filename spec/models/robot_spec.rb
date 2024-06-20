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

  describe '.process_command' do
    context 'when the command is PLACE' do
      context 'when the position is invalid' do
        it 'does not place the robot on the board' do
          expect { robot.process_command('PLACE 6,6,NORTH') }
            .to raise_error ArgumentError
        end
      end

      context 'when the position is valid' do
        it 'places the robot on the valid position and orientation' do
          robot.process_command('PLACE 1,2,NORTH')
          expect(robot.instance_variable_get(:@axis_x)).to eq 1
          expect(robot.instance_variable_get(:@axis_y)).to eq 2
          expect(robot.instance_variable_get(:@face)).to eq 'NORTH'
        end
      end
    end

    context 'when the command is MOVE' do
      context 'when the following moving position is invalid' do
        it 'doesn\'t move the rebot' do
          robot.process_command('PLACE 0,0,NORTH')
          robot.process_command('MOVE')

          expect(robot.instance_variable_get(:@axis_x)).to eq 0
          expect(robot.instance_variable_get(:@axis_y)).to eq 0
          expect(robot.instance_variable_get(:@face)).to eq 'NORTH'
        end
      end

      context 'when the following moving position is valid' do
        it 'moves the robot' do
          robot.process_command('PLACE 0,0,SOUTH')
          robot.process_command('MOVE')

          expect(robot.instance_variable_get(:@axis_x)).to eq 0
          expect(robot.instance_variable_get(:@axis_y)).to eq 1
          expect(robot.instance_variable_get(:@face)).to eq 'SOUTH'
        end
      end
    end

    context 'when the command is LEFT' do
      it 'changes the robot\'s direction to the left' do
        robot.process_command('PLACE 0,0,NORTH')

        robot.process_command('LEFT')
        expect(robot.instance_variable_get(:@face)).to eq 'WEST'
        robot.process_command('LEFT')
        expect(robot.instance_variable_get(:@face)).to eq 'SOUTH'
        robot.process_command('LEFT')
        expect(robot.instance_variable_get(:@face)).to eq 'EAST'
      end
    end

    context 'when the command is RIGHT' do
      it 'changes the robot\'s direction to the right' do
        robot.process_command('PLACE 0,0,NORTH')

        robot.process_command('RIGHT')
        expect(robot.instance_variable_get(:@face)).to eq 'EAST'
        robot.process_command('RIGHT')
        expect(robot.instance_variable_get(:@face)).to eq 'SOUTH'
        robot.process_command('RIGHT')
        expect(robot.instance_variable_get(:@face)).to eq 'WEST'
      end
    end

    context 'when the command is REPORT' do
      it 'outputs the current position and direction of the robot' do
        robot.process_command('PLACE 1,1,SOUTH')

        expect { robot.process_command('REPORT') }
          .to output("1,1,SOUTH\n").to_stdout
      end
    end
  end
end
