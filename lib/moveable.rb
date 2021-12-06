# frozen_string_literal: true

require './lib/pieces/bishop'
require './lib/pieces/king'
require './lib/pieces/knight'
require './lib/pieces/pawn'
require './lib/pieces/piece'
require './lib/pieces/queen'
require './lib/pieces/rook'

# Module used to check for valid moves for each piece.
module Moveable
  def legal_moves(board, piece) # rubocop:disable Metrics/MethodLength
    case piece.type
    when 'king'
      king_moves(board.piece_coord(piece))
    when 'queen'
      queen_moves(board.piece_coord(piece))
    when 'rook'
      rook_moves(board.piece_coord(piece))
    when 'knight'
      knight_moves(board.piece_coord(piece))
    when 'bishop'
      bishop_moves(board.piece_coord(piece))
    when 'pawn'
      pawn_moves(board.piece_coord(piece), colour, moved)
    end
  end

  # Returns true if the coordinate given is out of bounds on the 8x8 grid
  def out_of_bounds?(coord)
    return true unless coord[0].between?(0, 7) && coord[1].between?(0, 7)

    false
  end

  # Returns all possible king moves that would not put the king out of bounds.
  def king_moves(coord) # rubocop:disable Metrics/AbcSize
    row = coord[0]
    col = coord[1]
    moves_to_check = [[row - 1, col - 1], [row, col - 1], [row + 1, col - 1],
                      [row - 1, col], [row + 1, col],
                      [row - 1, col + 1], [row, col + 1], [row + 1, col + 1]]
    in_bound_moves = []
    moves_to_check.each do |move|
      in_bound_moves.push(move) unless out_of_bounds?(move)
    end
    in_bound_moves
  end

  # Returns all possible queen moves that would not put the king out of bounds.
  def queen_moves(coord)
    rook_moves(coord) + bishop_moves(coord)
  end

  # Returns all possible rook moves that would not put the king out of bounds.
  def rook_moves(coord)
    row = coord[0]
    col = coord[1]
    legal_moves = []
    8.times do |row_index|
      legal_moves.push([row_index, col]) unless row_index == row
    end
    8.times do |col_index|
      legal_moves.push([row, col_index]) unless col_index == col
    end
    legal_moves
  end

  # Returns all possible bishop moves that would not put the king out of bounds.
  def bishop_moves(coord)
    row = coord[0]
    col = coord[1]
    legal_moves = []
    (1..7).each do |increment|
      if (row - increment).between?(0, 7) && (col - increment).between?(0, 7)
        legal_moves.push([row - increment, col - increment])
      end
      if (row - increment).between?(0, 7) && (col + increment).between?(0, 7)
        legal_moves.push([row - increment, col + increment])
      end
      if (row + increment).between?(0, 7) && (col - increment).between?(0, 7)
        legal_moves.push([row + increment, col - increment])
      end
      if (row + increment).between?(0, 7) && (col + increment).between?(0, 7)
        legal_moves.push([row + increment, col + increment])
      end
    end
    legal_moves
  end

  # Returns all possible knight moves that would not put the king out of bounds.
  def knight_moves(coord) # rubocop:disable Metrics/AbcSize
    row = coord[0]
    col = coord[1]
    moves_to_check = [[row - 2, col - 1], [row - 2, col + 1], [row - 1, col + 2], [row + 1, col + 2],
                      [row + 2, col + 1], [row + 2, col - 1], [row + 1, col - 2], [row - 1, col - 2]]
    in_bound_moves = []
    moves_to_check.each do |move|
      in_bound_moves.push(move) unless out_of_bounds?(move)
    end
    in_bound_moves
  end

  def pawn_moves(coord, colour, moved)
    legal_moves = []
    if colour == 'white'
      legal_moves.push([coord[0] - 1, coord[1]])
      legal_moves.push([coord[0] - 2, coord[1]]) unless moved
    else
      legal_moves.push([coord[0] + 1, coord[1]])
      legal_moves.push([coord[0] + 2, coord[1]]) unless moved
    end
    legal_moves
  end
end
