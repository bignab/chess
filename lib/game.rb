# frozen_string_literal: true

require './lib/moveable'
require './lib/board'
require './lib/collisionable'
require './lib/capturable'
require './lib/checkable'
require './lib/castleable'
require './lib/enpassantable'

# Game class containing the game loop and other methods relating to the progress of the game.
class Game
  attr_reader :board, :turn

  include Moveable
  include Collisionable
  include Outputable
  include Capturable
  include Checkable
  include Castleable
  include Enpassantable

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
    king_in_check_message if king_in_check?(opposite_turn, @board)
    move_piece
    reset_enpassant_condition(@board, opposite_turn)
  end

  def next_turn
    @turn = @turn == 'white' ? 'black' : 'white'
  end

  def opposite_turn
    @turn == 'white' ? 'black' : 'white'
  end

  def move_piece
    parser_arr = []
    unique_piece = nil
    pieces = []
    loop do
      parser_arr = receive_input_and_parse
      if %w[king_side_castle queen_side_castle].include?(parser_arr)
        pieces = castle_coords(parser_arr, @turn, @board)
        illegal_castle_message if pieces == false
        next if pieces == false

        break unless king_in_check?(opposite_turn, simulate_board(@board, parser_arr, nil, @board.piece_coord(pieces[0]), @board.piece_coord(pieces[1])))

        illegal_castle_message
      else
        piece_and_arr = input_unique_piece(parser_arr)
        unique_piece = piece_and_arr[0]
        parser_arr = piece_and_arr[1]
        break unless king_in_check?(opposite_turn, simulate_board(@board, parser_arr[1], @board.piece_coord(unique_piece)))
      end
    end
    if %w[king_side_castle queen_side_castle].include?(parser_arr)
      @board.castle(pieces[0], pieces[1])
    else
      give_enpassant_condition(unique_piece) if check_enpassant_condition(unique_piece, @board.piece_coord(unique_piece), parser_arr[1])
      @board.occupy_square(unique_piece, parser_arr[1])
      check_pawn_promotion(unique_piece, parser_arr[1], parser_arr[4])
    end
  end

  def input_unique_piece(parser_arr)
    possible_pieces = @board.find_piece(parser_arr[0], @turn, parser_arr[2])
    unique_piece = filter_unique_piece(possible_pieces, parser_arr[1])
    while [0, 1].include?(unique_piece)
      unique_piece.zero? ? ambiguous_message(parser_arr[0]) : illegal_move_message
      parser_arr = receive_input_and_parse
      possible_pieces = @board.find_piece(parser_arr[0], @turn, parser_arr[2])
      unique_piece = filter_unique_piece(possible_pieces, parser_arr[1])
    end
    [unique_piece, parser_arr]
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
# test_game.next_turn
# test_game.board.squares[3][4] = Pawn.new('white')
# test_game.board.squares[3][4] = Pawn.new('black')
# # test_game.board.squares[2][2] = Knight.new('black')
# # # test_game.board.squares[3][1] = Bishop.new('white')
# test_game.board.squares[7][5] = nil
# test_game.board.squares[7][6] = nil
# # # test_game.board.squares[6][4] = nil
# test_game.board.squares[7][5] = nil
# test_game.board.squares[7][6] = nil
# test_game.board.print_board_local
# test_game.move_piece
# test_game.board.print_board_local

# test_game.king_in_check?(test_game.turn, test_game.board)
# test_game.move_piece(["pawn", [4, 2], [nil, 2], false, nil])
# test_game.board.squares[0][7] = test_game.board.new_piece('Q', 'white')
test_game.game_loop

