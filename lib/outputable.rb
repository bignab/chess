# frozen_string_literal: true

require './lib/string'

# Module used to display any and all output for the game.
module Outputable
  def print_board(board)
    puts '   a b c d e f g h'
    board.each_with_index do |row, r_index|
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
end
