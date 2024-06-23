require 'rails_helper'

RSpec.describe Robot do
  let(:robot) { create(:robot) }
  let(:service) { RobotCommandService.new(robot) }

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
end
