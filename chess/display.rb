require "colorize"
require_relative "board"
require_relative "cursor"
require "byebug"

class Display
  attr_reader :board, :cursor
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    # :TODO - implement logic to highlight selected piece
    system("clear")
    (0...board.grid.length).each_with_index do |_,index|
      render_background(index)
    end

  end


  def render_background(row_index)
    return_string = ""
    board.grid[row_index].each_with_index do |space,index|
      space = "  "
      if [row_index, index] == cursor.cursor_pos
        return_string << space.colorize({ :background => :red })
      elsif row_index.even?
        if index.even?
          return_string << space.colorize({:background => :white})
        else
          return_string << space.colorize({:background => :grey})
        end
      else
        if index.even?
          return_string << space.colorize({:background => :grey})
        else
          return_string << space.colorize({:background => :white})
        end
      end
    end
    puts return_string
  end

end


if __FILE__ == $PROGRAM_NAME
  board = Board.new
  display = Display.new(board)
  display.render
  sleep(1)
  display.cursor.cursor_pos = [1,0]
  display.render
  sleep(1)
  display.cursor.cursor_pos = [3,0]
  display.render
end
