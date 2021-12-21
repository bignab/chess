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
      next_turn
    end
  end

  def full_player_turn
    @board.print_board_local
    player_turn_message(@turn)
    move_piece(receive_input_and_parse)
  end

  def next_turn
    @turn = @turn == 'white' ? 'black' : 'white'
  end

  def move_piece(parser_arr)
    possible_pieces = @board.find_piece(parser_arr[0], @turn, parser_arr[2])
    unique_piece = filter_unique_piece(possible_pieces, parser_arr[1])
    while [0, 1].include?(unique_piece)
      unique_piece.zero? ? ambiguous_message(parser_arr[0]) : illegal_move_message
      parser_arr = receive_input_and_parse
      possible_pieces = @board.find_piece(parser_arr[0], @turn, parser_arr[2])
      unique_piece = filter_unique_piece(possible_pieces, parser_arr[1])
    end
    @board.occupy_square(unique_piece, parser_arr[1])
  end

  def valid_move?(piece, attempted_move)
    if legal_moves(@board, piece).include?(attempted_move) && !check_collision(@board, piece, attempted_move)
      return true
    end

    false
  end

  def filter_unique_piece(possible_pieces, attempted_move)
    unique_arr = []
    possible_pieces.each do |piece|
      unique_arr.push(piece) if valid_move?(piece, attempted_move)
    end
    return unique_arr[0] if unique_arr.length == 1
    return 0 if unique_arr.length > 1 # 0 represents an ambiguous move.

    1 # 1 represents an illegal move.
  end
end

test_game = Game.new(Board.new)
test_game.game_loop

# ['rook', [0, 6], [nil, nil], nil, false]
