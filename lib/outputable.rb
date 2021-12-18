# frozen_string_literal: true

require './lib/string'
require './lib/parser'

# Module used to display any and all output for the game.
module Outputable
  def print_board(squares)
    puts '   a b c d e f g h'
    squares.each_with_index do |row, r_index|
      print " #{8 - r_index} "
      row.each_with_index do |square, c_index|
        symbol_output = ' '
        symbol_output = square.convert_to_chess_symbol unless square.nil?
        if (r_index + c_index).even?
          print "#{symbol_output} ".bg_gray
        else
          print "#{symbol_output} ".bg_black
        end
      end
      print " #{8 - r_index}"
      puts
    end
    puts '   a b c d e f g h'
  end

  def intro_message
    puts 'Hello! Welcome to this CLI-based game of chess.'
  end

  def player_turn_message(player)
    current_player = 'White'
    current_player = 'Black' if player == 'black'
    puts "#{current_player} to move."
    puts 'Please enter your move using algebraic notation (e.g. Kxb3).'
  end

  def receive_input_and_parse
    result = 'Invalid'
    first_iter = true
    while result == 'Invalid'
      puts 'Invalid input, try again using algebraic notation.' unless first_iter == true
      first_iter = false
      result = Parser.new.parse_input(gets.chomp)
    end
    result
  end
end
