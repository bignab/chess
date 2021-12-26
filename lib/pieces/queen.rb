# frozen_string_literal: true

require './lib/pieces/piece'

# Class for the queen piece containing all queen related methods.
class Queen < Piece
  def initialize(colour, type = 'queen', moved: false)
    super(colour, type)
    @moved = moved
  end
end
