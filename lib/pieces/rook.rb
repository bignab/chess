# frozen_string_literal: true

require './lib/pieces/piece'

# Class for the rook piece containing all rook related methods.
class Rook < Piece
  def initialize(colour, type = 'rook', moved: false)
    super(colour, type)
    @moved = moved
  end
end
