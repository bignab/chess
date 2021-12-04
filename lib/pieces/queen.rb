# frozen_string_literal: true

require './lib/pieces/piece'

# Class for the queen piece containing all queen related methods.
class Queen < Piece
  def initialize(colour, type = 'queen')
    super(colour, type)
  end
end
