# frozen_string_literal: true

# Class used to parse algebraic chess notation into legal moves on the board.
class Parser
  def parse_input(raw_input) # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity
    input = raw_input.strip
    case input[0]
    when 'O' then castle(input)
    when 'K' then piece_move('king', input)
    when 'Q' then piece_move('queen', input)
    when 'R' then piece_move('rook', input)
    when 'B' then piece_move('bishop', input)
    when 'N' then piece_move('knight', input)
    when /[abcdefgh]/ then pawn_move(input)
    else 'Invalid'
    end
  end

  def piece_move(piece, input)
    case input.length
    when 3 then three_char_move(piece, input)
    when 4 then four_char_move(piece, input)
    when 5 then five_char_move(piece, input)
    when 6 then six_char_move(piece, input)
    else 'Invalid'
    end
  end

  def pawn_move(input, promo = nil)
    return pawn_move(input[0..-3], input[-1]) if input.length > 3 && input[-2] == '=' && input[-1] =~ /[QRBK]/

    case input.length
    when 2 then three_char_move('pawn', " #{input}", [nil, nil], promo) # _ at start b/c #three_char_move starts at [1].
    when 4
      three_char_move('pawn', " #{input[2..-1]}", corresponding_coord(input[0].intern), promo, captures: true)
    else
      'Invalid'
    end
  end

  def castle(input)
    case input
    when 'O-O'
      'king_side_castle'
    when 'O-O-O'
      'queen_side_castle'
    else
      'Invalid'
    end
  end

  # Returns an array with four elements: [type], [move], [disamb], [captures?].
  def three_char_move(type, input, disamb = [nil, nil], promotion = nil, captures: false)
    if input[1] =~ /[abcdefgh]/ && input[2] =~ /[12345678]/
      move = (input[1] + input[2]).intern
      [type, corresponding_coord(move), disamb, captures, promotion]
    else
      'Invalid'
    end
  end

  def four_char_move(type, input)
    case input[1]
    when 'x'
      three_char_move(type, input[1..-1], captures: true) # For input, passes on e.g. xc4
    when /[abcdefgh12345678]/
      three_char_move(type, input[1..-1], corresponding_coord(input[1].intern)) # Ex. input passed: ec4
    else
      'Invalid'
    end
  end

  def five_char_move(type, input) # rubocop:disable Metrics/MethodLength
    case input[1]
    when /[abcdefgh]/
      if input[2] =~ /[12345678]/
        return three_char_move(type, input[2..-1], corresponding_coord((input[1] + input[2]).intern))
      end
    when /[12345678]/
      if input[2] == 'x'
        return three_char_move(type, input[2..-1], corresponding_coord(input[1].intern), captures: true)
      end
    end
    'Invalid'
  end

  def six_char_move(type, input)
    if input[1] =~ /[abcdefgh]/ && input[2] =~ /[12345678]/ && input[3] == 'x'
      three_char_move(type, input[3..-1], corresponding_coord((input[1] + input[2]).intern), captures: true)
    else
      'Invalid'
    end
  end

  # Converts a square written in chess notation (e.g. c4) to a board coord (e.g. [4, 2])
  def corresponding_coord(square) # rubocop:disable Metrics/MethodLength
    dictionary = { a8: [0, 0], b8: [0, 1], c8: [0, 2], d8: [0, 3], e8: [0, 4], f8: [0, 5], g8: [0, 6], h8: [0, 7],
                   a7: [1, 0], b7: [1, 1], c7: [1, 2], d7: [1, 3], e7: [1, 4], f7: [1, 5], g7: [1, 6], h7: [1, 7],
                   a6: [2, 0], b6: [2, 1], c6: [2, 2], d6: [2, 3], e6: [2, 4], f6: [2, 5], g6: [2, 6], h6: [2, 7],
                   a5: [3, 0], b5: [3, 1], c5: [3, 2], d5: [3, 3], e5: [3, 4], f5: [3, 5], g5: [3, 6], h5: [3, 7],
                   a4: [4, 0], b4: [4, 1], c4: [4, 2], d4: [4, 3], e4: [4, 4], f4: [4, 5], g4: [4, 6], h4: [4, 7],
                   a3: [5, 0], b3: [5, 1], c3: [5, 2], d3: [5, 3], e3: [5, 4], f3: [5, 5], g3: [5, 6], h3: [5, 7],
                   a2: [6, 0], b2: [6, 1], c2: [6, 2], d2: [6, 3], e2: [6, 4], f2: [6, 5], g2: [6, 6], h2: [6, 7],
                   a1: [7, 0], b1: [7, 1], c1: [7, 2], d1: [7, 3], e1: [7, 4], f1: [7, 5], g1: [7, 6], h1: [7, 7],
                   a: [nil, 0], b: [nil, 1], c: [nil, 2], d: [nil, 3], e: [nil, 4], f: [nil, 5], g: [nil, 6], h: [nil, 7], # rubocop:disable Layout/LineLength
                   '1': [7, nil], '2': [6, nil], '3': [5, nil], '4': [4, nil], '5': [3, nil], '6': [2, nil], '7': [1, nil], '8': [0, nil] } # rubocop:disable Layout/LineLength
    dictionary[square]
  end
end
