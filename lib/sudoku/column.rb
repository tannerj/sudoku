module Sudoku
class Column
  attr_reader :id, :member_squares, :board
  include Container

  def initialize( args={} )
    @id = args[:id]
    @board = args.fetch(:board, NullBoard.new)
  end

  def calc_members
    @member_squares = (1..9).to_a.map! do |n|
      n = (9 * (n - 1)) + @id
    end
  end

  def get_members
    @board.get_members self
  end
end
end
