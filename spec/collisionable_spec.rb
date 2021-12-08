# frozen_string_literal: true

require './lib/game'

describe Collisionable do # rubocop:disable Metrics/BlockLength
  subject { Game.new(Board.new(empty: true)) }

  describe 'king_collision?' do
    it 'returns false when no piece colliding' do
      subject.board.squares[2][3] = King.new('black')
      subject.board.squares[2][5] = Rook.new('black')
      expect(subject.king_collision?(subject.board, [2, 4])).to be false
    end
    it 'returns true when piece is colliding' do
      subject.board.squares[2][3] = King.new('black')
      subject.board.squares[2][4] = Rook.new('black')
      expect(subject.king_collision?(subject.board, [2, 4])).to be true
    end
  end

  describe 'rook_collision?' do # rubocop:disable Metrics/BlockLength
    context 'when the piece does not collide' do
      it 'returns false when going right' do
        subject.board.squares[2][3] = Rook.new('black')
        subject.board.squares[2][7] = Pawn.new('black')
        expect(subject.rook_collision?(subject.board, subject.board.squares[2][3], [2, 5])).to be false
      end
      it 'returns false when going up' do
        subject.board.squares[6][6] = Rook.new('black')
        subject.board.squares[0][6] = Pawn.new('black')
        expect(subject.rook_collision?(subject.board, subject.board.squares[6][6], [1, 6])).to be false
      end
      it 'returns false when going left' do
        subject.board.squares[0][7] = Rook.new('black')
        subject.board.squares[0][2] = Pawn.new('black')
        expect(subject.rook_collision?(subject.board, subject.board.squares[0][7], [0, 3])).to be false
      end
      it 'returns false when going down' do
        subject.board.squares[3][3] = Rook.new('black')
        subject.board.squares[7][3] = Pawn.new('black')
        expect(subject.rook_collision?(subject.board, subject.board.squares[3][3], [6, 3])).to be false
      end
    end
    context 'when the piece collides' do
      it 'returns true when going right' do
        subject.board.squares[2][3] = Rook.new('black')
        subject.board.squares[2][5] = Pawn.new('black')
        expect(subject.rook_collision?(subject.board, subject.board.squares[2][3], [2, 7])).to be true
      end
      it 'returns true when going up' do
        subject.board.squares[6][6] = Rook.new('black')
        subject.board.squares[2][6] = Pawn.new('black')
        expect(subject.rook_collision?(subject.board, subject.board.squares[6][6], [1, 6])).to be true
      end
      it 'returns true when going left' do
        subject.board.squares[0][7] = Rook.new('black')
        subject.board.squares[0][3] = Pawn.new('black')
        expect(subject.rook_collision?(subject.board, subject.board.squares[0][7], [0, 2])).to be true
      end
      it 'returns true when going down' do
        subject.board.squares[3][3] = Rook.new('black')
        subject.board.squares[7][3] = Pawn.new('black')
        expect(subject.rook_collision?(subject.board, subject.board.squares[3][3], [7, 3])).to be true
      end
    end
  end

  describe 'knight_collision?' do
    it 'returns false when no piece colliding' do
      subject.board.squares[2][3] = Knight.new('black')
      subject.board.squares[2][6] = Rook.new('black')
      expect(subject.king_collision?(subject.board, [3, 6])).to be false
    end
    it 'returns true when piece is colliding' do
      subject.board.squares[2][3] = Knight.new('black')
      subject.board.squares[3][6] = Rook.new('black')
      expect(subject.king_collision?(subject.board, [3, 6])).to be true
    end
  end

  describe 'bishop_collision?' do # rubocop:disable Metrics/BlockLength
    context 'when the piece does not collide' do
      it 'returns false when going up-right' do
        subject.board.squares[3][3] = Bishop.new('black')
        subject.board.squares[0][6] = Pawn.new('black')
        expect(subject.bishop_collision?(subject.board, subject.board.squares[3][3], [1, 5])).to be false
      end
      it 'returns false when going down-right' do
        subject.board.squares[3][3] = Bishop.new('black')
        subject.board.squares[6][6] = Pawn.new('black')
        expect(subject.bishop_collision?(subject.board, subject.board.squares[3][3], [5, 5])).to be false
      end
      it 'returns false when going up-left' do
        subject.board.squares[3][3] = Bishop.new('black')
        subject.board.squares[0][0] = Pawn.new('black')
        expect(subject.bishop_collision?(subject.board, subject.board.squares[3][3], [1, 1])).to be false
      end
      it 'returns false when going down-left' do
        subject.board.squares[3][3] = Bishop.new('black')
        subject.board.squares[6][0] = Pawn.new('black')
        expect(subject.bishop_collision?(subject.board, subject.board.squares[3][3], [5, 1])).to be false
      end
    end
    context 'when the piece collides' do
      it 'returns true when going up-right' do
        subject.board.squares[3][3] = Bishop.new('black')
        subject.board.squares[2][4] = Pawn.new('black')
        expect(subject.bishop_collision?(subject.board, subject.board.squares[3][3], [0, 6])).to be true
      end
      it 'returns false when going down-right' do
        subject.board.squares[3][3] = Bishop.new('black')
        subject.board.squares[5][5] = Pawn.new('black')
        expect(subject.bishop_collision?(subject.board, subject.board.squares[3][3], [6, 6])).to be true
      end
      it 'returns false when going up-left' do
        subject.board.squares[3][3] = Bishop.new('black')
        subject.board.squares[1][1] = Pawn.new('black')
        expect(subject.bishop_collision?(subject.board, subject.board.squares[3][3], [0, 0])).to be true
      end
      it 'returns false when going down-left' do
        subject.board.squares[3][3] = Bishop.new('black')
        subject.board.squares[5][1] = Pawn.new('black')
        expect(subject.bishop_collision?(subject.board, subject.board.squares[3][3], [6, 0])).to be true
      end
    end
  end

  describe 'queen_collision?' do
    context 'when moving diagonally' do
      it 'returns false when no piece colliding' do
        subject.board.squares[3][3] = Queen.new('black')
        subject.board.squares[0][6] = Rook.new('black')
        expect(subject.queen_collision?(subject.board, subject.board.squares[3][3], [1, 5])).to be false
      end
      it 'returns true when piece is colliding' do
        subject.board.squares[3][3] = Queen.new('black')
        subject.board.squares[1][5] = Rook.new('black')
        expect(subject.queen_collision?(subject.board, subject.board.squares[3][3], [0, 6])).to be true
      end
    end
    context 'when moving vertically or horizontally' do
      it 'returns false when no piece colliding' do
        subject.board.squares[3][3] = Queen.new('black')
        subject.board.squares[3][6] = Rook.new('black')
        expect(subject.queen_collision?(subject.board, subject.board.squares[3][3], [3, 5])).to be false
      end
      it 'returns true when piece is colliding' do
        subject.board.squares[3][3] = Queen.new('black')
        subject.board.squares[3][6] = Rook.new('black')
        expect(subject.queen_collision?(subject.board, subject.board.squares[3][3], [3, 7])).to be true
      end
    end
  end

  describe 'pawn_collision?' do
    context 'when white' do
      context 'when moving a single step' do
        it 'returns false when no piece colliding' do
          subject.board.squares[3][3] = Pawn.new('white')
          subject.board.squares[0][3] = Rook.new('black')
          expect(subject.pawn_collision?(subject.board, subject.board.squares[3][3], [2, 3])).to be false
        end
        it 'returns true when piece is colliding' do
          subject.board.squares[3][3] = Pawn.new('white')
          subject.board.squares[2][3] = Rook.new('black')
          expect(subject.pawn_collision?(subject.board, subject.board.squares[3][3], [2, 3])).to be true
        end
      end
      context 'when moving two steps' do
        it 'returns false when no piece colliding' do
          subject.board.squares[3][3] = Pawn.new('white')
          subject.board.squares[0][3] = Rook.new('black')
          expect(subject.pawn_collision?(subject.board, subject.board.squares[3][3], [1, 3])).to be false
        end
        it 'returns true when piece is colliding on first step' do
          subject.board.squares[3][3] = Pawn.new('white')
          subject.board.squares[2][3] = Rook.new('black')
          expect(subject.pawn_collision?(subject.board, subject.board.squares[3][3], [1, 3])).to be true
        end
        it 'returns true when piece is colliding on second step' do
          subject.board.squares[3][3] = Pawn.new('white')
          subject.board.squares[1][3] = Rook.new('black')
          expect(subject.pawn_collision?(subject.board, subject.board.squares[3][3], [1, 3])).to be true
        end
      end
    end
  end
end
