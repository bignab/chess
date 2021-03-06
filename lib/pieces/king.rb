# frozen_string_literal: true

require './lib/pieces/piece'

# Class for the king piece containing all king related methods.
class King < Piece
  def initialize(colour, type = 'king', moved: false)
    super(colour, type)
    @moved = moved
  end
end
