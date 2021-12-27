# frozen_string_literal: true

require './lib/pieces/pawn'
require './lib/pieces/piece'

# Module used to provide methods to detect and implement en passant.
module Enpassantable
  def reset_enpassant_condition(board, colour)
    board.squares.flatten.each do |piece|
      piece.enpassant = false if !piece.nil? && piece.type == 'pawn' && piece.colour == colour
    end
  end

  def give_enpassant_condition(pawn)
    p pawn.enpassant = true
  end

  def check_enpassant_condition(piece, orig_pos, move)
    return false if piece.nil?

    case piece.colour
    when 'white'
      return true if piece.type == 'pawn' && move[0] == 4 && orig_pos[0] == 6
    when 'black'
      return true if piece.type == 'pawn' && move[0] == 3 && orig_pos[0] == 1
    end
    false
  end

  def check_enpassant_removal(piece, board)
    return false unless piece.type == 'pawn'

    coord = board.piece_coord(piece)
    case piece.colour
    when 'white'
      return true if !board.squares[coord[0] + 1][coord[1]].nil? && board.squares[coord[0] + 1][coord[1]].type == 'pawn' && board.squares[coord[0] + 1][coord[1]].enpassant == true
    when 'black'
      return true if !board.squares[coord[0] - 1][coord[1]].nil? && board.squares[coord[0] - 1][coord[1]].type == 'pawn' && board.squares[coord[0] - 1][coord[1]].enpassant == true
    end
    false
  end
end
