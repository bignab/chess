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

  describe '#piece_coord' do
    it 'locates the correct bishop coordinate' do
      test_piece = subject.squares[1][5]
      expect(subject.piece_coord(test_piece)).to eql([1, 5])
    end
    it 'locates the correct pawn coordinate' do
      test_piece = subject.squares[6][5]
      expect(subject.piece_coord(test_piece)).to eql([6, 5])
    end
  end

  describe '#find_piece' do
    it 'returns both knights' do
      knight_one = subject.squares[7][1]
      knight_two = subject.squares[7][6]
      knight_arr = [knight_one, knight_two]
      expect(subject.find_piece('knight', 'white', [nil, nil])).to match_array(knight_arr)
    end
    it 'returns one knight with useful disamb' do
      knight_two = subject.squares[7][6]
      knight_arr = [knight_two]
      expect(subject.find_piece('knight', 'white', [nil, 6])).to match_array(knight_arr)
    end
    it 'returns two knights with not useful disamb' do
      knight_one = subject.squares[7][1]
      knight_two = subject.squares[7][6]
      knight_arr = [knight_one, knight_two]
      expect(subject.find_piece('knight', 'white', [7, nil])).to match_array(knight_arr)
    end
    it 'returns correct knight with exact disamb' do
      knight_one = subject.squares[7][1]
      knight_arr = [knight_one]
      expect(subject.find_piece('knight', 'white', [7, 1])).to match_array(knight_arr)
    end
  end
end
