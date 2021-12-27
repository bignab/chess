# frozen_string_literal: true

require './lib/outputable'
require './lib/pieces/bishop'
require './lib/pieces/king'
require './lib/pieces/knight'
require './lib/pieces/pawn'
require './lib/pieces/piece'
require './lib/pieces/queen'
require './lib/pieces/rook'
require './lib/enpassantable'

# Board class containing the board and representations of all the pieces on it, and methods making changes to the board.
class Board
  attr_reader :squares

  include Outputable
  include Enpassantable

  def initialize(empty: false)
    @squares = initialize_squares
    starting_pieces unless empty
  end

  # Creates an 8x8 2D array, with every element set to nil.
  def initialize_squares
    Array.new(8) { Array.new(8) { nil } }
  end

  # Place starting pieces onto the board.
  def starting_pieces # rubocop:disable Metrics/AbcSize
    @squares[0].replace([Rook.new('black'), Knight.new('black'), Bishop.new('black'), Queen.new('black'),
                         King.new('black'), Bishop.new('black'), Knight.new('black'), Rook.new('black')])
    @squares[1].replace(Array.new(8) { Pawn.new('black') })
    @squares[6].replace(Array.new(8) { Pawn.new('white') })
    @squares[7].replace([Rook.new('white'), Knight.new('white'), Bishop.new('white'), Queen.new('white'),
                         King.new('white'), Bishop.new('white'), Knight.new('white'), Rook.new('white')])
  end

  # Returns the coordinate of the given piece passed into the method.
  def piece_coord(piece)
    @squares.each_with_index do |row, index|
      next if row.all?(nil)

      return [index, row.index(piece)] unless row.index(piece).nil?
    end
    nil
  end

  def new_piece(type, colour)
    case type
    when 'Q'
      Queen.new(colour)
    when 'R'
      Rook.new(colour)
    when 'B'
      Bishop.new(colour)
    when 'N'
      Knight.new(colour)
    end
  end

  def find_piece(type, colour, disamb)
    row_range = disamb[0].nil? ? [0, 1, 2, 3, 4, 5, 6, 7] : [disamb[0]]
    col_range = disamb[1].nil? ? [0, 1, 2, 3, 4, 5, 6, 7] : [disamb[1]]
    piece_arr = []
    row_range.each do |row_coord|
      col_range.each do |col_coord|
        unless @squares[row_coord][col_coord].nil?
          if @squares[row_coord][col_coord].colour == colour && @squares[row_coord][col_coord].type == type
            piece_arr.push(@squares[row_coord][col_coord])
          end
        end
      end
    end
    piece_arr
  end

  def occupy_square(piece, move)
    piece.moved = true
    orig_pos = piece_coord(piece)
    @squares[move[0]][move[1]] = piece
    @squares[orig_pos[0]][orig_pos[1]] = nil
    @squares[move[0] - 1][move[1]] = nil if piece.colour == 'black' && check_enpassant_removal(piece, self)
    @squares[move[0] + 1][move[1]] = nil if piece.colour == 'white' && check_enpassant_removal(piece, self)
  end

  def castle(king, rook)
    king_coord = piece_coord(king)
    rook_coord = piece_coord(rook)
    delta = king_coord[1] - rook_coord[1]
    n_king_coord = delta.positive? ? [king_coord[0], king_coord[1] - 2] : [king_coord[0], king_coord[1] + 2]
    n_rook_coord = delta.positive? ? [n_king_coord[0], n_king_coord[1] + 1] : [n_king_coord[0], n_king_coord[1] - 1]
    occupy_square(king, n_king_coord)
    occupy_square(rook, n_rook_coord)
  end

  def print_board_local
    print_board(@squares)
  end
end

# test_board = Board.new(empty: true)
# p test_board.piece_coord(test_board.squares[5][3])
# test_board.print_board(test_board.squares)
