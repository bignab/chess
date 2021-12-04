# frozen_string_literal: true

require './lib/pieces/piece'

# Class for the pawn piece containing all pawn related methods.
class Pawn < Piece
  def initialize(colour, type = 'pawn')
    super(colour, type)
  end
end
