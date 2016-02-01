module Sudoku
class NullSquare
  attr_reader :id, :value, :possible_values, 
  
  def initialize( args= {} )
    @id = nil
    @value = nil
    @possible_values = nil
  end

  def update(square)
    raise NotImplementedError, "NullSquare does not implement update"
  end

  def update_peers
    raise NotImplementedError, "NUllSquare does not implement update_peers"
  end
end
end
