# frozen_string_literal: true

require './lib/pieces/bishop'
require './lib/pieces/king'
require './lib/pieces/knight'
require './lib/pieces/pawn'
require './lib/pieces/piece'
require './lib/pieces/queen'
require './lib/pieces/rook'

# Module used to check for valid moves for each piece.
module Collisionable
  def check_collision(board, piece, move)
    case piece.type
    when 'king'
      king_collision?(board, move)
    when 'queen'
      queen_collision?(board, piece, move)
    when 'rook'
      rook_collision?(board, piece, move)
    when 'knight'
      knight_collision?(board, move)
    when 'bishop'
      bishop_collision?(board, piece, move)
    when 'pawn'
      pawn_collision?(board, piece, move)
    end
  end

  # Returns true if the king will collide with another piece as it moves.
  def king_collision?(board, move)
    return false if board.squares[move[0]][move[1]].nil?

    true
  end

  # Returns true if the queen will collide with another piece as it moves.
  def queen_collision?(board, piece, move)
    delta_row = board.piece_coord(piece)[0] - move[0]
    delta_col = board.piece_coord(piece)[1] - move[1]
    if delta_row.nonzero? && delta_col.nonzero?
      bishop_collision?(board, piece, move)
    else
      rook_collision?(board, piece, move)
    end
  end

  # Returns true if the rook will collide with another piece as it moves.
  def rook_collision?(board, piece, move)
    delta_row = board.piece_coord(piece)[0] - move[0]
    delta_col = board.piece_coord(piece)[1] - move[1]
    if delta_row.nonzero?
      start = 1 if delta_row.positive?
      start = -1 if delta_row.negative?
      (0..(delta_row * start - 1)).each do |row_index|
        factor = row_index * start
        return true unless board.squares[move[0] + factor][move[1]].nil?
      end
    elsif delta_col.nonzero?
      start = 1 if delta_col.positive?
      start = -1 if delta_col.negative?
      (0..(delta_col * start - 1)).each do |col_index|
        factor = col_index * start
        return true unless board.squares[move[0]][move[1] + factor].nil?
      end
    end
    false
  end

  # Returns true if the knight will collide with another piece as it moves.
  def knight_collision?(board, move)
    return false if board.squares[move[0]][move[1]].nil?

    true
  end

  # Returns true if the bishop will collide with another piece as it moves.
  def bishop_collision?(board, piece, move)
    delta_row = board.piece_coord(piece)[0] - move[0]
    delta_col = board.piece_coord(piece)[1] - move[1]
    row_sign = delta_row.positive? ? 1 : -1
    col_sign = delta_col.positive? ? 1 : -1
    (0..(delta_row.abs - 1)).each do |index|
      return true unless board.squares[move[0] + index * row_sign][move[1] + index * col_sign].nil?
    end
    false
  end

  # Returns true if the pawn will collide with another piece as it moves.
  def pawn_collision?(board, piece, move)
    return true unless board.squares[move[0]][move[1]].nil?

    delta_row = board.piece_coord(piece)[0] - move[0]
    if delta_row.abs == 2
      if piece.colour == 'white'
        return true unless board.squares[move[0] + 1][move[1]].nil?
      else
        return true unless board.squares[move[0] - 1][move[1]].nil?
      end
    end
    false
  end
end
