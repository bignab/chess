# frozen_string_literal: true

require './lib/pieces/bishop'
require './lib/pieces/king'
require './lib/pieces/knight'
require './lib/pieces/pawn'
require './lib/pieces/piece'
require './lib/pieces/queen'
require './lib/pieces/rook'

# Module used to check if castling is valid.
module Castleable
  def castle_coords(side, turn, board)
    b_king = board.squares[0][4]
    w_king = board.squares[7][4]
    case side
    when 'king_side_castle'
      w_rook = board.squares[7][7]
      b_rook = board.squares[0][7]
      return [w_king, w_rook] if turn == 'white' && castling_valid?(side, board, turn, w_king, w_rook)
      return [b_king, b_rook] if turn == 'black' && castling_valid?(side, board, turn, b_king, b_rook)
    when 'queen_side_castle'
      w_rook = board.squares[7][0]
      b_rook = board.squares[0][0]
      return [w_king, w_rook] if turn == 'white' && castling_valid?(side, board, turn, w_king, w_rook)
      return [b_king, b_rook] if turn == 'black' && castling_valid?(side, board, turn, b_king, b_rook)
    end
    false
  end

  def castling_valid?(side, board, colour, king, rook)
    if castling_king_valid?(king, colour) &&
       castling_rook_valid?(rook, colour) &&
       castling_unobstructed_path?(side, board, colour)
      return true
    end

    false
  end

  def castling_king_valid?(king, colour)
    return true if !king.nil? && king.type == 'king' && king.colour == colour && king.moved == false

    false
  end

  def castling_rook_valid?(rook, colour)
    return true if !rook.nil? && rook.type == 'rook' && rook.colour == colour && rook.moved == false

    false
  end

  def castling_unobstructed_path?(side, board, colour) # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    case side
    when 'king_side_castle'
      return (board.squares[0][5].nil? && board.squares[0][6].nil?) if colour == 'black'
      return (board.squares[7][5].nil? && board.squares[7][6].nil?) if colour == 'white'
    when 'queen_side_castle'
      return (board.squares[0][1].nil? && board.squares[0][2].nil? && board.squares[0][3].nil?) if colour == 'black'
      return (board.squares[7][1].nil? && board.squares[7][2].nil? && board.squares[7][3].nil?) if colour == 'white'
    end
    false
  end
end
