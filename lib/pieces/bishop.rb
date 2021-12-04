# frozen_string_literal: true

require './lib/pieces/piece'
require './lib/outputable'

# Class for the bishop piece containing all bishop related methods.
class Bishop < Piece
  include Outputable
  def initialize(colour, type = 'bishop')
    super(colour, type)
  end
end
