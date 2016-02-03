module Sudoku
class Container
  attr_reader :id, :member_squares, :board

  def initialize( args={} )
    @id = args[:id]
    @board = args.fetch(:board, NullBoard.new)
    @member_squares = []
    @member_calculator = args[:member_calculator]
  end

  def calc_members
    @member_calculator.calc_members( @id )
  end

  def get_members
    @board.set_container_members self
  end
  
  def add_member( args={} )
    if square = validate_square( args.fetch(:square, nil) )
      @member_squares << square
    end
  end

  def update_peers( args={} )
    altered_peer = args[:square]
    if validate_square( altered_peer )
      member_squares.each{ |member| member.update( altered_peer ) }
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
