# frozen_string_literal: true

require './lib/outputable'
require './lib/pieces/bishop'
require './lib/pieces/king'
require './lib/pieces/knight'
require './lib/pieces/pawn'
require './lib/pieces/piece'
require './lib/pieces/queen'
require './lib/pieces/rook'

# Board class containing the board and representations of all the pieces on it, and methods making changes to the board.
class Board
  attr_reader :squares

  include Outputable

  def initialize
    @squares = initialize_squares
    starting_pieces
  end

  # Creates an 8x8 2D array, with every element set to nil.
  def initialize_squares
    Array.new(8) { Array.new(8) { nil } }
  end

  def starting_pieces
    @squares[0].replace([Rook.new('black'), Knight.new('black'), Bishop.new('black'), Queen.new('black'),
                         King.new('black'), Bishop.new('black'), Knight.new('black'), Rook.new('black')])
    @squares[1].replace(Array.new(8) { Pawn.new('black') })
    @squares[6].replace(Array.new(8) { Pawn.new('white') })
    @squares[7].replace([Rook.new('white'), Knight.new('white'), Bishop.new('white'), Queen.new('white'),
                         King.new('white'), Bishop.new('white'), Knight.new('white'), Rook.new('white')])
  end

  def piece_coord(piece)
    # TBD
  end
end

test_board = Board.new
test_board.print_board(test_board.squares)
