module Sudoku
class Board
  attr_reader :squares, :row_length, :columns

  def self.create(args= {})
    board = self.new( args )
  end

  def initialize( args={} )
    @squares = []
    @squares[0] = Sudoku::NullSquare.new
    @row_length = 9
    @columns = []
    @columns << Sudoku::NullContainer.new
    populate_members( args )
  end

  def update_square(args={})
    begin
      @squares[args[:id]].value = args[:value]
    rescue Sudoku::ValueOutOfBoundsError

    end
  end
  
  def update_peers(square)

  end

  def set_container_members( container )
    container.calc_members.each do |square_id|
      container.add_member square: @squares[square_id]
    end
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

  def populate_members( args={} )
    set_squares( args )
    set_columns
  end

  def set_squares( args={} )
    square_object = args.fetch(:square_object, Sudoku::Square)
    args[:square_values].each_char.with_index do |char, i| 
      char = nil if char == "0"
      i += 1
      @squares[i] = square_object.new(id: i, value: char, board: self)
    end
  end

  def set_columns
    (1..9).to_a.each do |i|
       new_column = Container.new(
         id: i,
         member_calculator: MemberCalculator::Column.new,
         board: self
       )
       set_container_members( new_column )
       @columns[i] = new_column 
    end
  end

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
