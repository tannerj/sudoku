module Sudoku
class NullContainer
  attr_reader :id, :member_squares, :board
  
  def initialize( args={} )
    @board = args.fetch(:board, NullBoard.new)
  end

  def calc_members
    raise NotImplementedError
  end

  def get_members
    raise NotImplementedError
  end
  
  def add_member( args={} )
    raise NotImplementedError
  end

  def update_peers( args={} )
    raise NotImplementedError
  end
end
end
