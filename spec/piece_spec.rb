# frozen_string_literal: true

require './lib/pieces/bishop'
require './lib/pieces/king'
require './lib/pieces/knight'
require './lib/pieces/pawn'
require './lib/pieces/piece'
require './lib/pieces/queen'
require './lib/pieces/rook'

describe Piece do
  describe '#convert_to_chess_symbol' do
    context 'when black' do
      let(:king) { King.new('white') }
      let(:queen) { Queen.new('white') }
      let(:rook) { Rook.new('white') }
      let(:bishop) { Bishop.new('white') }
      let(:knight) { Knight.new('white') }
      let(:pawn) { Pawn.new('white') }
      it 'if piece is a king' do
        expect(king.convert_to_chess_symbol).to eql('♚')
      end
      it 'if piece is a queen' do
        expect(queen.convert_to_chess_symbol).to eql('♛')
      end
      it 'if piece is a rook' do
        expect(rook.convert_to_chess_symbol).to eql('♜')
      end
      it 'if piece is a bishop' do
        expect(bishop.convert_to_chess_symbol).to eql('♝')
      end
      it 'if piece is a knight' do
        expect(knight.convert_to_chess_symbol).to eql('♞')
      end
      it 'if piece is a pawn' do
        expect(pawn.convert_to_chess_symbol).to eql('♟︎')
      end
    end
    context 'when white' do
      let(:king) { King.new('black') }
      let(:queen) { Queen.new('black') }
      let(:rook) { Rook.new('black') }
      let(:bishop) { Bishop.new('black') }
      let(:knight) { Knight.new('black') }
      let(:pawn) { Pawn.new('black') }
      it 'if piece is a king' do
        expect(king.convert_to_chess_symbol).to eql('♔')
      end
      it 'if piece is a queen' do
        expect(queen.convert_to_chess_symbol).to eql('♕')
      end
      it 'if piece is a rook' do
        expect(rook.convert_to_chess_symbol).to eql('♖')
      end
      it 'if piece is a bishop' do
        expect(bishop.convert_to_chess_symbol).to eql('♗')
      end
      it 'if piece is a knight' do
        expect(knight.convert_to_chess_symbol).to eql('♘')
      end
      it 'if piece is a pawn' do
        expect(pawn.convert_to_chess_symbol).to eql('♙')
      end
    end
  end
end
