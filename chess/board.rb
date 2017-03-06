
class Board
  attr_accessor :grid
  def initialize
    @grid = Array.new(8) {Array.new(8)}
  end

  def populate
    populate_pawn(1)
    populate_pawn(6)

  end

  def is_valid?(pos)
    return true if pos[0].between?(0, 7) && pos[1].between?(0, 7)
    false 
  end

  def [](position)
    row,column = position
    grid[row][column]
  end

  def []=(position, value)
    row,column = position
    self.grid[row][column] = value
  end

  def populate_pawn(row)
    grid[row].each_with_index do |square, index|
      grid[row][index] = "P"#Pawn.new
    end
  end

  def move_piece(start_pos, end_pos)
    piece = self[start_pos]
    self[end_pos] = piece
    self[start_pos] = nil
    #add error handling to this from phase 1
  end

  def render
    row_length = 3 * grid[0].length - 3
    puts "-" * row_length
    grid.each do |el|
      display_row = el.join(" | ")
      puts display_row
      puts "-" * display_row.length
    end
  end
end

# if __FILE__ == $PROGRAM_NAME
#   board = Board.new
#   board.populate
#   board.render
#   board.move_piece([1,1], [3,1])
#   board.render
# end
