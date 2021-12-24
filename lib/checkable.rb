# frozen_string_literal: true

require './lib/moveable'
require './lib/collisionable'
require './lib/capturable'
require './lib/object'

# Module to provide methods to check if either side's king is in check.
module Checkable
  include Moveable
  include Capturable

  def king_in_check?(turn, board)
    king_coordinate = opposite_king_coord(turn, board)
    board.squares.each do |row|
      row.each do |square|
        piece_moves = square.nil? ? [] : legal_moves(board, square)
        next unless piece_moves.include?(king_coordinate) && square.colour == turn

        return true if check_capture(board, square, king_coordinate, turn)
      end
    end
    false
  end

  def opposite_king_coord(turn, board)
    opposite_colour = turn == 'white' ? 'black' : 'white'
    king = board.find_piece('king', opposite_colour, [nil, nil])
    board.piece_coord(king[0]) if king.size == 1
  end

  def simulate_board(board, piece_coord, move)
    sim_board = Marshal.load(Marshal.dump(board))
    sim_piece = sim_board.squares[piece_coord[0]][piece_coord[1]]
    sim_board.occupy_square(sim_piece, move)
    sim_board
  end
end
