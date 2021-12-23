# frozen_string_literal: true

require './lib/game'

describe Moveable do # rubocop:disable Metrics/BlockLength
  subject { Game.new }

  describe 'king_moves' do # rubocop:disable Metrics/BlockLength
    context 'when in the middle of the board' do
      it 'returns correct legal moves' do
        correct_legal_moves = [[2, 2], [2, 3], [2, 4],
                               [3, 2], [3, 4],
                               [4, 2], [4, 3], [4, 4]]
        expect(subject.king_moves([3, 3])).to match_array(correct_legal_moves)
      end
    end
    context 'when on the corners of the board' do
      it 'on the top-left corner' do
        correct_legal_moves = [[0, 1], [1, 0], [1, 1]]
        expect(subject.king_moves([0, 0])).to match_array(correct_legal_moves)
      end
      it 'on the top-right corner' do
        correct_legal_moves = [[0, 6], [1, 6], [1, 7]]
        expect(subject.king_moves([0, 7])).to match_array(correct_legal_moves)
      end
      it 'on the bottom-left corner' do
        correct_legal_moves = [[6, 0], [6, 1], [7, 1]]
        expect(subject.king_moves([7, 0])).to match_array(correct_legal_moves)
      end
      it 'on the bottom-right corner' do
        correct_legal_moves = [[7, 6], [6, 6], [6, 7]]
        expect(subject.king_moves([7, 7])).to match_array(correct_legal_moves)
      end
      context 'when on the edge of the board' do
        it 'on the right edge' do
          correct_legal_moves = [[3, 6], [3, 7], [4, 6], [5, 6], [5, 7]]
          expect(subject.king_moves([4, 7])).to match_array(correct_legal_moves)
        end
      end
    end
  end

  describe 'rook_moves' do
    context 'when in the middle of the board' do
      it 'on square [3,3]' do
        correct_legal_moves = [[0, 3], [1, 3], [2, 3], [4, 3], [5, 3], [6, 3], [7, 3],
                               [3, 0], [3, 1], [3, 2], [3, 4], [3, 5], [3, 6], [3, 7]]
        expect(subject.rook_moves([3, 3])).to match_array(correct_legal_moves)
      end
    end
  end

  describe 'bishop_moves' do
    context 'when in the middle of the board' do
      it 'on square [4,5]' do
        correct_legal_moves = [[0, 1], [1, 2], [2, 3], [3, 4], [5, 6], [6, 7], [3, 6],
                               [2, 7], [5, 4], [6, 3], [7, 2]]
        expect(subject.bishop_moves([4, 5])).to match_array(correct_legal_moves)
      end
    end
  end

  describe 'queen_moves' do
    context 'when in the middle of the board' do
      it 'on square [4,5]' do
        correct_legal_moves = [[0, 1], [1, 2], [2, 3], [3, 4], [5, 6], [6, 7], [3, 6],
                               [2, 7], [5, 4], [6, 3], [7, 2], [4, 6], [4, 7], [4, 0],
                               [4, 1], [4, 2], [4, 3], [4, 4], [5, 5], [6, 5], [7, 5],
                               [3, 5], [2, 5], [1, 5], [0, 5]]
        expect(subject.queen_moves([4, 5])).to match_array(correct_legal_moves)
      end
    end
  end

  describe 'knight_moves' do
    context 'when in the middle of the board' do
      it 'on square [4,5]' do
        correct_legal_moves = [[2, 4], [2, 6], [3, 7], [5, 7], [6, 6], [6, 4], [5, 3], [3, 3]]
        expect(subject.knight_moves([4, 5])).to match_array(correct_legal_moves)
      end
    end
    context 'when on the edge of the board' do
      it 'on square [0, 4]' do
        correct_legal_moves = [[1, 2], [2, 3], [2, 5], [1, 6]]
        expect(subject.knight_moves([0, 4])).to match_array(correct_legal_moves)
      end
    end
  end

  describe 'pawn_moves' do
    context 'when white' do
      it 'on square [3,5]' do
        correct_legal_moves = [[2, 5]]
        expect(subject.pawn_moves([3, 5], 'white', true, subject.board, subject.board.squares[0][6])).to match_array(correct_legal_moves)
      end
      it 'on square [6,0]' do
        correct_legal_moves = [[5, 0], [4, 0]]
        expect(subject.pawn_moves([6, 0], 'white', false, subject.board, subject.board.squares[0][6])).to match_array(correct_legal_moves)
      end
    end
    context 'when black' do
      it 'on square [4,5]' do
        correct_legal_moves = [[4, 5]]
        expect(subject.pawn_moves([3, 5], 'black', true, subject.board, subject.board.squares[0][1])).to match_array(correct_legal_moves)
      end
      it 'on square [1,0]' do
        correct_legal_moves = [[2, 0], [3, 0]]
        expect(subject.pawn_moves([1, 0], 'black', false, subject.board, subject.board.squares[0][1])).to match_array(correct_legal_moves)
      end
    end
  end
end
