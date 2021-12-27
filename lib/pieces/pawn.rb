# frozen_string_literal: true

require './lib/pieces/piece'

# Class for the pawn piece containing all pawn related methods.
class Pawn < Piece
  attr_accessor :enpassant

  def initialize(colour, type = 'pawn', moved: false, enpassant: false)
    super(colour, type)
    @moved = moved
    @enpassant = enpassant
  end
end
