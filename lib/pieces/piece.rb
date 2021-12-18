# frozen_string_literal: true

# Parent class for all the chess pieces, and will contain methods that are shared across all pieces.
class Piece
  attr_reader :colour, :type
  attr_accessor :moved

  def initialize(colour, type = nil)
    @colour = colour
    @type = type
  end

  def convert_to_chess_symbol # rubocop:disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Metrics/AbcSize
    case type
    when 'king' then colour == 'black' ? '♔' : '♚'
    when 'queen' then colour == 'black' ? '♕' : '♛'
    when 'rook' then colour == 'black' ? '♖' : '♜'
    when 'bishop' then colour == 'black' ? '♗' : '♝'
    when 'knight' then colour == 'black' ? '♘' : '♞'
    when 'pawn' then colour == 'black' ? '♙' : '♟︎'
    end
  end
end
