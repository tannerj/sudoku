module Sudoku
class Column
  attr_reader :id, :member_squares, :board
  include Container

  def initialize( args={} )
    @id = args[:id]
    @board = args.fetch(:board, NullBoard.new)
    @member_squares = []
  end

  def calc_members
    (1..9).to_a.map! do |n|
      n = (9 * (n - 1)) + @id
    end
  end

  def get_members
    @board.set_container_members self
  end
  
  def add_member( args={} )
    if square = validate_square( args.fetch(:square, nil) )
      @member_squares << square
    end
  end

  private

  def validate_square( square )
    if calc_members.include? square.id
      return square
    end
    return false
  end
end
end
