require 'rails_helper'

RSpec.describe RobotCommandService do
  let(:robot) { create(:robot) }
  let(:service) { described_class.new(robot) }

  describe '.execute' do
    context 'when the command is PLACE' do
      context 'when the position is invalid' do
        it 'does not place the robot on the board' do
          expect { service.execute('PLACE 6,6,SOUTH') }
            .to raise_error ArgumentError
        end
      end

      context 'when the position is valid' do
        before do
          service.execute('PLACE 0,0,NORTH')
        end

        it { expect { service.execute('PLACE 1,2,SOUTH') }.to(change(robot, :axis_x).from(0).to(1)) }
        it { expect { service.execute('PLACE 1,2,SOUTH') }.to(change(robot, :axis_y).from(0).to(2)) }
        it { expect { service.execute('PLACE 1,2,SOUTH') }.to(change(robot, :face).from('NORTH').to('SOUTH')) }
      end
    end

    context 'when the command is MOVE' do
      context 'when the following moving position is invalid' do
        before do
          service.execute('PLACE 0,0,NORTH')
        end

        it { expect { service.execute('MOVE') }.not_to(change(robot, :axis_x)) }
        it { expect { service.execute('MOVE') }.not_to(change(robot, :axis_y)) }
        it { expect { service.execute('MOVE') }.not_to(change(robot, :face)) }
      end

      context 'when the following moving position is valid' do
        before do
          service.execute('PLACE 0,0,SOUTH')
        end

        it { expect { service.execute('MOVE') }.not_to(change(robot, :axis_x)) }
        it { expect { service.execute('MOVE') }.to(change(robot, :axis_y).from(0).to(1)) }
        it { expect { service.execute('MOVE') }.not_to(change(robot, :face)) }
      end
    end

    context 'when the command is LEFT' do
      before do
        service.execute('PLACE 0,0,NORTH')
      end

      it 'changes the robot\'s direction to the left' do
        expect { service.execute('LEFT') }.to(change(robot, :face).from('NORTH').to('WEST'))
        expect { service.execute('LEFT') }.to(change(robot, :face).from('WEST').to('SOUTH'))
        expect { service.execute('LEFT') }.to(change(robot, :face).from('SOUTH').to('EAST'))
      end
    end

    context 'when the command is RIGHT' do
      before do
        service.execute('PLACE 0,0,NORTH')
      end

      it 'changes the robot\'s direction to the right' do
        expect { service.execute('RIGHT') }.to(change(robot, :face).from('NORTH').to('EAST'))
        expect { service.execute('RIGHT') }.to(change(robot, :face).from('EAST').to('SOUTH'))
        expect { service.execute('RIGHT') }.to(change(robot, :face).from('SOUTH').to('WEST'))
      end
    end

    context 'when the command is RESET' do
      before do
        service.execute('PLACE 0,0,NORTH')
      end

      it { expect { service.execute('RESET') }.to(change(robot, :placed).from(true).to(false)) }
    end
  end
end
