module Sudoku
class Game
  def initialize; end
end

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

class PeerValueCollisionError < StandardError; end
class ValueOutOfBoundsError < StandardError; end

class Square
  attr_reader :id, :value, :possible_values

  def self.create(args={})
    raise ArgumentError.new("A square must have an id") if args[:id].nil?
    square = self.new id: args[:id], value: args[:value], board: args[:board]
  end

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
    @board = args[:board]
  end

  def value=(value)
    raise ValueOutOfBoundsError if value < 1 || value > 9
    @value = value
    update_peers if @board
  end

  def update(square)
    return if square.value.nil?
    @possible_values.delete_if do | possible_value |
      true if possible_value == square.value
    end
    @board.illegal_move(square) if @possible_values.empty?
    @value = @possible_values[0] if @possible_values.length == 1
  end

  def update_peers
    @board.update_peers self
  end
end

class Console; end
end
