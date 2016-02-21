module Sudoku
class Board
  attr_reader :squares, :row_length, :columns, :rows, :boxes

  def self.create(args= {})
    board = self.new( args )
  end

  def initialize( args={} )
    @row_length = args.fetch(:row_length, 9)
    @squares, @columns, @rows, @boxes = [], [], [], []
    @squares[0] = Sudoku::NullSquare.new
    @columns[0] = Sudoku::NullContainer.new
    @rows[0] = Sudoku::NullContainer.new
    @boxes[0] = Sudoku::NullContainer.new
    populate_members( args )
  end

  def update_square(args={})
    begin
      @squares[args[:id]].value = args[:value]
    rescue Sudoku::ValueOutOfBoundsError

    end
  end
  
  def update_peers( square )
    peers = find_peers( square )
    peers.each { |peer| peer.update( square ) }
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

  def illegal_move()
    
  end

  private

  def populate_members( args={} )
    set_squares( args )
    set_containers
  end

  def set_squares( args={} )
    square_object = args.fetch(:square_object, Sudoku::Square)
    args[:square_values].each_char.with_index do |char, i| 
      char = nil if char == "0"
      i += 1
      @squares[i] = square_object.new(id: i, value: char, board: self)
    end
  end
  
  def set_containers
    { Column: :columns, Row: :rows, Box: :boxes }.each do |klass, instance_variable|
      (1..9).to_a.each do |i|
        new_container = Container.new(
          id: i,
          member_calculator: MemberCalculator.const_get(klass).new,
          board: self
        )
        set_container_members( new_container )
        self.send(instance_variable)[i] = new_container
      end
    end
  end

  def find_peers( square )
    peers = []
    # if square.id is <= 9 square is in row 1
    # else dividing the id by 9.0 and taking the
    # ceil will give us the row.
    if ( square.id > 9 )
      row_id = ( square.id / 9.0 ).ceil
    else
      row_id = 1
    end

    if ( square.id < 9 )
      column_id = square.id
    else
      column_id = square.id % 9
    end

    #calc box
    row_multiplier = ( ( row_id / 3.0 ).floor ) * 3
    box_column = ( column_id / 3.0 ).ceil
    box_id = row_multiplier + box_column

    peers << @rows[row_id].member_squares
    peers << @columns[column_id].member_squares
    peers << @boxes[box_id].member_squares
    peers.flatten
  end
end
end
