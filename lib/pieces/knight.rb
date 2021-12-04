# frozen_string_literal: true

require './lib/pieces/piece'

# Class for the knight piece containing all knight related methods.
class Knight < Piece
  def initialize(colour, type = 'knight')
    super(colour, type)
  end
end
