# frozen_string_literal: true

require './lib/board'

describe Board do
  subject { Board.new }

  describe '#initialize_squares' do
    it 'creates an 8x8 nil array representing the chess board' do
      nil_board = [[nil, nil, nil, nil, nil, nil, nil, nil],
                   [nil, nil, nil, nil, nil, nil, nil, nil],
                   [nil, nil, nil, nil, nil, nil, nil, nil],
                   [nil, nil, nil, nil, nil, nil, nil, nil],
                   [nil, nil, nil, nil, nil, nil, nil, nil],
                   [nil, nil, nil, nil, nil, nil, nil, nil],
                   [nil, nil, nil, nil, nil, nil, nil, nil],
                   [nil, nil, nil, nil, nil, nil, nil, nil]]
      expect(subject.initialize_squares).to eql(nil_board)
    end
  end
end
