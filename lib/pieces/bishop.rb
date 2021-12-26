# frozen_string_literal: true

require './lib/pieces/piece'

# Class for the bishop piece containing all bishop related methods.
class Bishop < Piece
  def initialize(colour, type = 'bishop', moved: false)
    super(colour, type)
    @moved = moved
  end
end
