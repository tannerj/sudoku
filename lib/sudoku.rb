module Sudoku
class Square
  attr_reader :id, :value, :peers

  def initialize( args={} )
    @id = args.fetch(:id)
    @value = args.fetch(:value, [1,2,3,4,5,6,7,8,9])
    @peers = []
  end

  def add_peers( peer_array )
    peer_array.each do |peer|
      
    end
  end
end

class Unit
  attr_reader :id, :members

  def initialize( args={} )
    @id = args.fetch(:id)
    @members = {}
  end

  def add_member(member)
    if !@members.include? member 
      @members[member.id.to_sym] = member
      return true
    end
    false
  end
end

class Row < Unit
end

class Column < Unit
end

class Box < Unit
end

class Board
  ROW_IDS = "ABCDEFGHI"
  COL_IDS = "123456789"
  BOX_IDS = "123456789"

  attr_reader :squares, :units, :rows, :columns, :boxes

  def initialize( args={} )
    @squares = {}
    @units = []
    @rows = {}
    @columns = {}
    @boxes = {}
    @state = args.fetch(:state, nil)
    @square_klass = args.fetch(:square_klass, Sudoku::Square)
    @unit_klass = args.fetch(:unit_klass, Sudoku::Unit)
    @row_klass = args.fetch(:row_klass, Sudoku::Row)
    @column_klass = args.fetch(:column_klass, Sudoku::Column)
    @box_klass = args.fetch(:box_klass, Sudoku::Box)
    
    build
  end

  private

  def build
    generate_squares
    generate_units
    generate_square_peers
  end

  def generate_squares
    square_ids = cross ROW_IDS, COL_IDS
    square_ids.each do |id|
      square = @square_klass.new id: id
      @squares[id] = square
    end
  end
  
  def generate_units
    generate_rows
    generate_columns
    generate_boxes
  end
  
  def generate_rows
    ROW_IDS.each_char do |row_id|
      row = Row.new id: row_id
      COL_IDS.each_char do |col_id|
        row.add_member @squares[row_id + col_id]
      end
      @rows[row.id.to_sym] = row
      @units << row
    end
  end

  def generate_columns
    COL_IDS.each_char do |col_id|
      col = Column.new id: col_id
      ROW_IDS.each_char do |row_id|
        col.add_member @squares[row_id + col_id]
      end
      @columns[col.id] = col
      @units << col
    end
  end

  def generate_boxes
    row_groups = ["ABC", "DEF", "GHI"]
    col_groups = ["123", "456", "789"]
    box_member_ids = []
    row_groups.each do |row_group|
      col_groups.each do |col_group|
        box_member_ids << cross( row_group, col_group )
      end
    end
    
    box_member_ids.each_with_index do |box_members, index|
      box = @box_klass.new id: index + 1
      box_members.each do |member|
        box.add_member( @squares[member] )
      end
      @boxes[index + 1] = box
      @units << box
    end
  end

  def generate_square_peers
    @units.each do |unit|
      unit.members.each do |member|
        member.add_peers( unit.members )
      end
    end
  end

  def cross(a, b)
    result = []
    a.each_char do |a_char|
      b.each_char do |b_char|
        result << "#{a_char + b_char}"
      end
    end
    result
  end
end
end
