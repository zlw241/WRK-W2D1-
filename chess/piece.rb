

module Slideable
  def moves
    case self.symbol
    when :Q
      move_dirs([:diagonal, :horizontal, :verticle])
    when :B
      move_dirs([:diagonal])
    when :R
      move_dirs([:vertical, :horizontal])
    end
  end

  private

  POSITION_CHANGES = {:diagonal => [[1,1], [1,-1], [-1, 1], [-1, -1]],
    :horizontal => [[0,1], [0,-1]],
    :vertical => [[1,0], [-1,0]] }

  def move_dirs(*direction_symbols)
    all_moves = []
    direction_symbols.each do |direction_sym|
      all_moves += get_moves(direction_sym)
    end
    all_moves
  end

  #   all_moves = []
  #   all_moves.concat(horizontal_dirs)
  #   all_moves.concat(vertical_dirs)
  #   all_moves.concat(diagonal_dirs)
  #   all_moves
  # end

  def get_moves(dir_symbol)
    moves_in_dir = []
    POSITION_CHANGES[dir_symbol].each do |change|
      dx, dy = change
      moves_in_dir.concat(grow_unblocked_moves_in_dirs(dx, dy))
    end
    moves_in_dir
  end

  # def horizontal_dirs
  #   horizontal_moves = []
  #   POSITION_CHANGES[:horizontal].each do |change|
  #     dx, dy = change
  #     horizontal_moves.concat(grow_unblocked_moves_in_dirs(dx, dy))
  #   end
  #   horizontal_moves
  # end
  #
  # def vertical_dirs
  #   vertical_moves = []
  #   POSITION_CHANGES[:vertical].each do |change|
  #     dx, dy = change
  #     vertical_moves.concat(grow_unblocked_moves_in_dirs(dx, dy))
  #   end
  #   vertical_moves
  # end
  #
  # def diagonal_dirs
  #   diagonal_moves = []
  #   POSITION_CHANGES[:diagonal].each do |change|
  #     dx, dy = change
  #     diagonal_moves.concat(grow_unblocked_moves_in_dirs(dx, dy))
  #   end
  #   diagonal_moves
  # end


  # def horizontal_dirs
  #   positions = []
  #
  #   (0...board.grid.length).each do |potential_column|
  #     positions << [current_row, potential_column] unless [current_row, potential_column] == current_position
  #   end
  #   positions
  # end
  #
  # def vertical_dirs
  #   positions = []
  #   current_row, current_column = current_position
  #   (0...board.grid.length).each do |potential_row|
  #     positions << [potential_row, current_column] unless [potential_row, current_column] == current_position
  #   end
  #   positions
  # end
  #
  # def diagonal_dirs
  #   directions = [[1,1], [1,-1], [-1, 1], [-1, -1]]
  #   positions = []
  #   current_row, current_column = current_position
  #   directions.each do |dir|
  #     row, col = current_row, current_column
  #     while board.is_valid?([row, col])
  #       row += dir[0]
  #       col += dir[1]
  #       positions << [row, col]
  #     end
  #   end
  #   positions
  # end

  def grow_unblocked_moves_in_dirs(dx, dy)
    moves = []
    current_row, current_column = current_position
    while is_valid?([current_row, current_column]) && empty?
      moves << [current_row, current_column]
      current_row += dx
      current_column += dy
    end
    moves << [current_row, current_column] if is_valid?([current_row, current_column])
    moves[1..-1]
  end
end

module Stepable
  POSITION_CHANGES = {
    :knight => [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]
    :king => [[1, 1], [1, -1], [-1, 1], [-1, -1], [0, 1], [0, -1], [1, 0], [-1, 0]]
  }

  def moves
    case self.symbol
    when :N
      get_moves(:knight)
    when :K
      get_moves(:king)
    end
  end

  def move_dirs(piece_type)
    current_row, current_column = current_position
    possible = POSITION_CHANGES[piece_type].map do |change|
      [(current_row + change[0]), (current_column + change[1])]
    end
    valid = possible.select { |move| is_valid?(move) }
  end
end

class Piece
  attr_reader :current_position
  def initialize(current_position, color)
    @current_position = current_position
    @color = color
  end

  def to_s
    self.symbol.to_s
  end

  def symbol
  end

  def empty?
    self.class == NullPiece
  end

  def valid_moves(end_pos)
    current_row, current_column = current_position
    end_row, end_column = end_pos
    DIFFERENCES.include?([current_row - end_row, current_column - end_column])
  end

  def move_into_check(to_pos)

  end

  def is_valid?(pos)
    return true if pos[0].between?(0, 7) && pos[1].between?(0, 7)
    false
  end
end

class King < Piece

  def symbol
    :K
  end

  # def move_diffs
  #
  # end
end

class Knight < Piece

  def symbol
    :N
  end
end

class Bishop < Piece

  def symbol
    :B
  end
end

class Rook < Piece

  def symbol
    :R
  end
end

class Queen < Piece

  def symbol
    :Q
  end
end

class Pawn < Piece
  DIFFERENCES = [[1,0], [1,1], [1,-1]]

  def initialize(current_position, direction)
    @direction = direction
    super(current_position)
  end

  def symbol
    :P
  end

  def at_start_row?
    if direction == -1 && current_position[0] == 6
      true
    elsif direction == 1 && current_position[0] == 1
      true
    else
      false
    end
  end

  def forward_dir
    if at_start_row?

  end

  def forward_steps

  end

  def side_attacks

  end

end
