# frozen_string_literal: true

# Board class containing the board and representations of all the pieces on it, and methods making changes to the board.
class Board
  attr_reader :squares

  def initialize
    @squares = initialize_squares
  end

  def pretty_print
    # TBD
  end

  def initialize_squares
    Array.new(8) { Array.new(8) { nil } }
  end
end

# test_board = Board.new
# p test_board.squares
