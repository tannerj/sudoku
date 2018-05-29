module Sudoku
class Game
  
  attr_reader :state

  def initialize(args={})
    @state = args.fetch(:state, [])
  end
end
end
