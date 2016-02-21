module Sudoku
class Square
  attr_reader :id, :value, :possible_values
  attr_accessor :column, :row, :box

  def initialize(args={})
    raise ArgumentError.new("A valid id must be provided") if args[:id] == nil
    if (args[:id] < 1 || args[:id] > 81)
      raise ArgumentError.new("The id provided is not in bounds")
    end
    if (!args[:value].nil? && ( args[:value] < 1 || args[:value] > 9 ))
      raise ArgumentError.new("The value must be between 1 and 9 inclusive")
    end
    @id = args[:id]
    @possible_values = (args[:value].nil?) ? (1..9).to_a : [args[:value]]
    @value = args[:value]
    @board = args.fetch(:board, NullBoard.new)
  end

  def value=(value)
    raise ValueOutOfBoundsError if value < 1 || value > 9
    @value = value
    @possible_values = [value]
    update_peers
  end

  def update(square)
    return if square.id == id
    return if square.value.nil?
    @possible_values.delete_if do | possible_value |
      true if possible_value == square.value
    end
    @board.illegal_move if @possible_values.empty?
    @value = @possible_values[0] if @possible_values.length == 1
  end

  def update_peers
    @board.update_peers self
  end
end
end
