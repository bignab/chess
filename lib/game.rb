# frozen_string_literal: true

require './lib/moveable'
require './lib/board'
require './lib/collisionable'
require './lib/capturable'

# Game class containing the game loop and other methods relating to the progress of the game.
class Game
  attr_reader :board

  include Moveable
  include Collisionable
  include Outputable
  include Capturable

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
    check_pawn_promotion(unique_piece, parser_arr[1], parser_arr[4])
  end

  def valid_move?(piece, attempted_move)
    if (legal_moves(@board, piece).include?(attempted_move) && !check_collision(@board, piece, attempted_move)) ||
       (legal_moves(@board, piece).include?(attempted_move) && check_capture(@board, piece, attempted_move, @turn))
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

  def check_pawn_promotion(piece, move, promote_to)
    if piece.type == 'pawn'
      if piece.colour == 'white' && move[0].zero?
        @board.squares[move[0]][move[1]] = @board.new_piece(promote_to, 'white')
      elsif piece.colour == 'black' && move[0] == 7
        @board.squares[move[0]][move[1]] = @board.new_piece(promote_to, 'black')
      end
    end
  end
end

test_game = Game.new
# test_game.board.squares[6][7] = Pawn.new('black')
# test_game.move_piece(["pawn", [0, 6], [nil, 7], true, "R"])
# test_game.board.squares[0][7] = test_game.board.new_piece('Q', 'white')
test_game.game_loop
