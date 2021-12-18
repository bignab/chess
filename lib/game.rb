# frozen_string_literal: true

require './lib/moveable'
require './lib/board'
require './lib/collisionable'

# Game class containing the game loop and other methods relating to the progress of the game.
class Game
  attr_reader :board

  include Moveable
  include Collisionable
  include Outputable

  def initialize(board = Board.new, turn = 'white', end_condition: false)
    @board = board
    @turn = turn
    @end_condition = end_condition
  end

  def game_loop
    intro_message
    until @end_condition
      full_player_turn
    end
  end

  def full_player_turn
    @board.print_board_local
    player_turn_message(@turn)
    p receive_input_and_parse # temp until move function implemented
    next_turn
  end

  def next_turn
    @turn = @turn == 'white' ? 'black' : 'white'
  end

  def move_piece(piece)
    # TBD
  end
end

test_game = Game.new(Board.new)
test_game.game_loop
