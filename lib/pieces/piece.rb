# frozen_string_literal: true

# Parent class for all the chess pieces, and will contain methods that are shared across all pieces.
class Piece
  attr_reader :colour, :type

  def initialize(colour, type = nil)
    @colour = colour
    @type = type
  end

  def convert_to_chess_symbol # rubocop:disable Metrics/MethodLength, Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Metrics/AbcSize
    case type
    when 'king'
      colour == 'black' ? '♔' : '♚'
    when 'queen'
      colour == 'black' ? '♕' : '♛'
    when 'rook'
      colour == 'black' ? '♖' : '♜'
    when 'bishop'
      colour == 'black' ? '♗' : '♝'
    when 'knight'
      colour == 'black' ? '♘' : '♞'
    when 'pawn'
      colour == 'black' ? '♙' : '♟︎'
    end
  end
end
