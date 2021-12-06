# frozen_string_literal: true

require './lib/moveable'
require './lib/board'

# Game class containing the game loop and other methods relating to the progress of the game.
class Game
  attr_reader :board

  include Moveable

  def initialize(board = Board.new)
    @board = board
  end

  def game_loop
    # TBD
  end
end

test_game = Game.new
test_game.rook_moves([3, 3])
