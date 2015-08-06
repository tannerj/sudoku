module Sudoku
class Board
  attr_reader :squares, :row_length

  def update_square(square_id)

  end
  
  def update_peers(square_id)

  end

  def illegal_move(square)

  end

  def self.square_position(args={})
    if(args[:id] < 1 || args[:id] > 81)
      raise ArgumentError.new("The square id must be between 1 and 81")
    end
    id = args[:id]
    row = (id / 9.0).floor
    column = (id % 9)
    column = 9 if column == 0
    row += 1 unless column == 9
    position = "r#{row}c#{column}"
  end
  
  private
  def calc_rows
    rows = {}
    @row_length.times do |n|
      min = n*1
      max = n*9
      rows[n] = (min..max).to_a 
    end
    rows
  end
end
end
