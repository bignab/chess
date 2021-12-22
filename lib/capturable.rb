# frozen_string_literal: true

require './lib/pieces/bishop'
require './lib/pieces/king'
require './lib/pieces/knight'
require './lib/pieces/pawn'
require './lib/pieces/piece'
require './lib/pieces/queen'
require './lib/pieces/rook'

# Module used to check for valid moves for each piece.
module Capturable
  def check_capture(board, piece, move, turn)
    case piece.type
    when 'king'
      king_capture?(board, move, turn)
    when 'queen'
      queen_capture?(board, piece, move, turn)
    when 'rook'
      rook_capture?(board, piece, move, turn)
    when 'knight'
      knight_capture?(board, move, turn)
    when 'bishop'
      bishop_capture?(board, piece, move, turn)
    when 'pawn'
      pawn_capture?(board, piece, move, turn)
    end
  end

  # Returns target_sq coords if there is collision with an opposite colour piece, nil otherwise.
  def king_capture?(board, move, turn)
    target_sq = board.squares[move[0]][move[1]]
    opposite_colour = turn == 'white' ? 'black' : 'white'
    return true if !target_sq.nil? && target_sq.colour == opposite_colour

    false
  end

  # Returns target_sq coords if the queen can capture with the move, nil otherwise.
  def queen_capture?(board, piece, move, turn)
    delta_row = board.piece_coord(piece)[0] - move[0]
    delta_col = board.piece_coord(piece)[1] - move[1]
    if delta_row.nonzero? && delta_col.nonzero?
      bishop_capture?(board, piece, move, turn)
    else
      rook_capture?(board, piece, move, turn)
    end
  end

  # Returns target_sq coords if the rook can capture with the move, nil otherwise.
  def rook_capture?(board, piece, move, turn)
    delta_row = board.piece_coord(piece)[0] - move[0]
    delta_col = board.piece_coord(piece)[1] - move[1]
    opposite_colour = turn == 'white' ? 'black' : 'white'
    if delta_row.nonzero?
      start = 1 if delta_row.positive?
      start = -1 if delta_row.negative?
      (1..(delta_row * start)).each do |row_index|
        factor = row_index * start
        target_sq = board.squares[board.piece_coord(piece)[0] - factor][board.piece_coord(piece)[1]]
        unless target_sq.nil?
          return target_sq.colour == opposite_colour && target_sq == board.squares[move[0]][move[1]] ? true : false
        end
      end
    elsif delta_col.nonzero?
      start = 1 if delta_col.positive?
      start = -1 if delta_col.negative?
      (1..(delta_col * start)).each do |col_index|
        factor = col_index * start
        target_sq = board.squares[board.piece_coord(piece)[0]][board.piece_coord(piece)[1] - factor]
        unless target_sq.nil?
          return target_sq.colour == opposite_colour && target_sq == board.squares[move[0]][move[1]] ? true : false
        end
      end
    end
    false
  end

  # Returns target_sq coords if the knight can capture with the move, nil otherwise.
  def knight_capture?(board, move, turn)
    target_sq = board.squares[move[0]][move[1]]
    opposite_colour = turn == 'white' ? 'black' : 'white'
    return true if !target_sq.nil? && target_sq.colour == opposite_colour

    false
  end

  # Returns true if the bishop will collide with another piece as it moves.
  def bishop_capture?(board, piece, move, turn)
    delta_row = board.piece_coord(piece)[0] - move[0]
    delta_col = board.piece_coord(piece)[1] - move[1]
    row_sign = delta_row.positive? ? 1 : -1
    col_sign = delta_col.positive? ? 1 : -1
    opposite_colour = turn == 'white' ? 'black' : 'white'
    (1..(delta_row.abs)).each do |index|
      target_sq = board.squares[board.piece_coord(piece)[0] - index * row_sign][board.piece_coord(piece)[1] - index * col_sign]
      unless target_sq.nil?
        return target_sq.colour == opposite_colour && target_sq == board.squares[move[0]][move[1]] ? true : false
      end
    end

    false
  end

  # Returns true if the pawn will collide with another piece as it moves.
  def pawn_capture?(board, piece, move, turn)
    pawn_coord = board.piece_coord(piece)
    target_sq = board.squares[move[0]][move[1]]
    left_sq = turn == 'white' ? [pawn_coord[0] - 1, pawn_coord[1] - 1] : [pawn_coord[0] + 1, pawn_coord[1] - 1]
    right_sq = turn == 'white' ? [pawn_coord[0] - 1, pawn_coord[1] + 1] : [pawn_coord[0] + 1, pawn_coord[1] + 1]
    opposite_colour = turn == 'white' ? 'black' : 'white'
    if (move == left_sq || move == right_sq) && !target_sq.nil?
      return target_sq.colour == opposite_colour ? true : false
    end

    false
  end
end
