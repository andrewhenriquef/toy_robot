require 'rails_helper'

RSpec.describe Robot do
  let(:robot) { create(:robot) }

  describe 'validations' do
    describe '.axis_x' do
      it { is_expected.to validate_presence_of(:axis_x) }
    end

    describe '.axis_x' do
      it { is_expected.to validate_presence_of(:axis_x) }
    end

    describe '.face' do
      it { is_expected.to validate_presence_of(:face) }
    end

    describe '.board' do
      it { is_expected.to validate_presence_of(:board) }
    end
  end

  context 'when there is no board provided' do
    it 'raises an error' do
      expect { create(:robot, board: nil) }
        .to(
          raise_error(
            ActiveRecord::RecordInvalid,
            /Validation failed: Board must exist, Board can't be blank/
          )
        )
    end
  end

  describe '.process_command' do
    context 'when the command is PLACE' do
      context 'when the position is invalid' do
        it 'does not place the robot on the board' do
          expect { robot.process_command('PLACE 6,6,SOUTH') }
            .to raise_error ArgumentError
        end
      end

      context 'when the position is valid' do
        before do
          robot.process_command('PLACE 1,2,SOUTH')
        end

        it { expect(robot.axis_x).to eq 1 }
        it { expect(robot.axis_y).to eq 2 }
        it { expect(robot.face).to eq 'SOUTH' }
      end
    end

    context 'when the command is MOVE' do
      context 'when the following moving position is invalid' do
        before do
          robot.process_command('PLACE 0,0,NORTH')
          robot.process_command('MOVE')
        end

        it { expect(robot.axis_x).to eq 0 }
        it { expect(robot.axis_y).to eq 0 }
        it { expect(robot.face).to eq 'NORTH' }
      end

      context 'when the following moving position is valid' do
        before do
          robot.process_command('PLACE 0,0,SOUTH')
          robot.process_command('MOVE')
        end

        it { expect(robot.axis_x).to eq 0 }
        it { expect(robot.axis_y).to eq 1 }
        it { expect(robot.face).to eq 'SOUTH' }
      end
    end

    context 'when the command is LEFT' do
      it 'changes the robot\'s direction to the left' do
        robot.process_command('PLACE 0,0,NORTH')

        robot.process_command('LEFT')
        expect(robot.face).to eq 'WEST'
        robot.process_command('LEFT')
        expect(robot.face).to eq 'SOUTH'
        robot.process_command('LEFT')
        expect(robot.face).to eq 'EAST'
      end
    end

    context 'when the command is RIGHT' do
      it 'changes the robot\'s direction to the right' do
        robot.process_command('PLACE 0,0,NORTH')

        robot.process_command('RIGHT')
        expect(robot.face).to eq 'EAST'
        robot.process_command('RIGHT')
        expect(robot.face).to eq 'SOUTH'
        robot.process_command('RIGHT')
        expect(robot.face).to eq 'WEST'
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
