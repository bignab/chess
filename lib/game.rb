# frozen_string_literal: true

require './lib/moveable'
require './lib/board'
require './lib/collisionable'

# Game class containing the game loop and other methods relating to the progress of the game.
class Game
  attr_reader :board

  include Moveable
  include Collisionable

  def initialize(board = Board.new)
    @board = board
  end

  def game_loop
    # TBD
  end

  def move_piece(piece)
    # TBD
  end
end

test_game = Game.new(Board.new(empty: true))
test_game.board.squares[3][3] = Rook.new('black')
test_game.board.squares[7][3] = Pawn.new('black')
test_game.board.print_board(test_game.board.squares)
puts test_game.rook_collision?(test_game.board, test_game.board.squares[3][3], [7, 3])
