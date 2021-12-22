# frozen_string_literal: true

require './lib/game'

describe Capturable do # rubocop:disable Metrics/BlockLength
  subject { Game.new(Board.new(empty: true)) }

  describe 'king_capture' do
    it 'returns false when no piece targeted' do
      subject.board.squares[2][3] = King.new('white')
      subject.board.squares[2][5] = Rook.new('black')
      expect(subject.king_capture?(subject.board, [2, 4], 'white')).to be false
    end
    it 'returns false when no piece capturable' do
      subject.board.squares[2][3] = King.new('white')
      subject.board.squares[2][4] = Rook.new('white')
      expect(subject.king_capture?(subject.board, [2, 4], 'white')).to be false
    end
    it 'returns true when piece is capturable' do
      subject.board.squares[2][3] = King.new('white')
      subject.board.squares[2][4] = Rook.new('black')
      expect(subject.king_capture?(subject.board, [2, 4], 'white')).to be true
    end
  end

  describe 'rook_capture' do
    context 'when white' do
      it 'returns false when no collision' do
        subject.board.squares[2][3] = Rook.new('white')
        subject.board.squares[2][7] = Pawn.new('black')
        expect(subject.rook_capture?(subject.board, subject.board.squares[2][3], [2, 5], 'white')).to be false
      end
      it 'returns true when capturable' do
        subject.board.squares[2][3] = Rook.new('white')
        subject.board.squares[2][7] = Pawn.new('black')
        expect(subject.rook_capture?(subject.board, subject.board.squares[2][3], [2, 7], 'white')).to be true
      end
      it 'returns false when blocked before capturing' do
        subject.board.squares[2][3] = Rook.new('white')
        subject.board.squares[2][5] = Pawn.new('white')
        subject.board.squares[2][7] = Pawn.new('black')
        expect(subject.rook_capture?(subject.board, subject.board.squares[2][3], [2, 7], 'white')).to be false
      end
      it 'returns false when overshooting' do
        subject.board.squares[2][3] = Rook.new('white')
        subject.board.squares[2][6] = Pawn.new('black')
        expect(subject.rook_capture?(subject.board, subject.board.squares[2][3], [2, 7], 'white')).to be false
      end
    end
  end

  describe 'knight_capture' do
    it 'returns false when not capturing on square' do
      subject.board.squares[2][3] = Knight.new('white')
      subject.board.squares[2][6] = Rook.new('black')
      expect(subject.king_capture?(subject.board, [3, 6], 'white')).to be false
    end
    it 'returns true when capturing on square' do
      subject.board.squares[2][3] = Knight.new('white')
      subject.board.squares[3][5] = Rook.new('black')
      expect(subject.king_capture?(subject.board, [3, 5], 'white')).to be true
    end
  end

  describe 'bishop_capture' do # rubocop:disable Metrics/BlockLength
    context 'when white' do
      it 'returns false when unable to capture' do
        subject.board.squares[3][3] = Bishop.new('white')
        subject.board.squares[0][6] = Pawn.new('black')
        expect(subject.bishop_capture?(subject.board, subject.board.squares[3][3], [1, 5], 'white')).to be false
      end
      it 'returns true when capturable' do
        subject.board.squares[3][3] = Bishop.new('white')
        subject.board.squares[0][6] = Pawn.new('black')
        expect(subject.bishop_capture?(subject.board, subject.board.squares[3][3], [0, 6], 'white')).to be true
      end
      it 'returns true when capturable 2' do
        subject.board.squares[3][3] = Bishop.new('white')
        subject.board.squares[0][0] = Pawn.new('black')
        expect(subject.bishop_capture?(subject.board, subject.board.squares[3][3], [0, 0], 'white')).to be true
      end
      it 'returns false when blocked before capturing' do
        subject.board.squares[3][3] = Bishop.new('white')
        subject.board.squares[1][1] = Pawn.new('black')
        subject.board.squares[0][0] = Pawn.new('black')
        expect(subject.bishop_capture?(subject.board, subject.board.squares[3][3], [0, 0], 'white')).to be false
      end
      it 'returns false when overshooting' do
        subject.board.squares[3][3] = Bishop.new('white')
        subject.board.squares[5][1] = Pawn.new('black')
        expect(subject.bishop_capture?(subject.board, subject.board.squares[3][3], [6, 0], 'white')).to be false
      end
    end
  end

  describe 'queen_capture' do
    context 'when moving diagonally' do
      it 'returns true when capturable' do
        subject.board.squares[3][3] = Queen.new('white')
        subject.board.squares[0][6] = Pawn.new('black')
        expect(subject.queen_capture?(subject.board, subject.board.squares[3][3], [0, 6], 'white')).to be true
      end
    end
    context 'when moving vertically or horizontally' do
      it 'returns true when capturable' do
        subject.board.squares[2][3] = Queen.new('white')
        subject.board.squares[2][7] = Pawn.new('black')
        expect(subject.queen_capture?(subject.board, subject.board.squares[2][3], [2, 7], 'white')).to be true
      end
    end
  end

  describe 'pawn_capture' do
    context 'when white' do
      it 'returns false when trying to capture illegal square' do
        subject.board.squares[4][4] = Pawn.new('white')
        subject.board.squares[3][4] = Pawn.new('black')
        expect(subject.pawn_capture?(subject.board, subject.board.squares[4][4], [3, 4], 'white')).to be false
      end
      it 'returns false when trying to capture empty (legal) square' do
        subject.board.squares[4][4] = Pawn.new('white')
        subject.board.squares[3][4] = Pawn.new('black')
        expect(subject.pawn_capture?(subject.board, subject.board.squares[4][4], [3, 5], 'white')).to be false
      end
      it 'returns false when trying to capture same colour square' do
        subject.board.squares[4][4] = Pawn.new('white')
        subject.board.squares[3][5] = Pawn.new('white')
        subject.board.squares[3][4] = Pawn.new('black')
        expect(subject.pawn_capture?(subject.board, subject.board.squares[4][4], [3, 5], 'white')).to be false
      end
      it 'returns true when trying to capture square' do
        subject.board.squares[4][4] = Pawn.new('white')
        subject.board.squares[3][5] = Pawn.new('black')
        subject.board.squares[3][4] = Pawn.new('black')
        expect(subject.pawn_capture?(subject.board, subject.board.squares[4][4], [3, 5], 'white')).to be true
      end
    end
    context 'when black' do
      it 'returns false when trying to capture illegal square' do
        subject.board.squares[4][4] = Pawn.new('white')
        subject.board.squares[3][4] = Pawn.new('black')
        expect(subject.pawn_capture?(subject.board, subject.board.squares[3][4], [4, 4], 'black')).to be false
      end
      it 'returns false when trying to capture empty (legal) square' do
        subject.board.squares[4][4] = Pawn.new('white')
        subject.board.squares[3][4] = Pawn.new('black')
        expect(subject.pawn_capture?(subject.board, subject.board.squares[3][4], [4, 3], 'black')).to be false
      end
      it 'returns true when trying to capture square' do
        subject.board.squares[4][4] = Pawn.new('white')
        subject.board.squares[4][3] = Pawn.new('white')
        subject.board.squares[3][4] = Pawn.new('black')
        expect(subject.pawn_capture?(subject.board, subject.board.squares[3][4], [4, 3], 'black')).to be true
      end
    end
  end
end
