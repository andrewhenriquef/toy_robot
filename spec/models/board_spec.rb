require 'rails_helper'

RSpec.describe Board do
  subject(:board) { Board.new(width: 5, height: 5) }

  describe '.initialize' do
    context 'when initialized with valid dimensions' do
      it 'creates a board with the specified width and height' do
        expect(board.width).to eq 5
        expect(board.height).to eq 5
      end
    end
  end

  describe '.valid_position?' do
    context 'when the position is within the board boundaries' do
      it { expect(board.valid_position?(0, 0)).to be true }
      it { expect(board.valid_position?(4, 4)).to be true }
    end

    context 'when the position is outside the board boundaries' do
      it { expect(board.valid_position?(-1, 0)).to be false }
      it { expect(board.valid_position?(0, -1)).to be false }
      it { expect(board.valid_position?(5, 0)).to be false }
      it { expect(board.valid_position?(0, 5)).to be false }
    end
  end
end
