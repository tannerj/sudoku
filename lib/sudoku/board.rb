module Sudoku
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
      @square_klass = args.fetch(:square_klass, Sudoku::Square)
      @unit_klass = args.fetch(:unit_klass, Sudoku::Unit)
      @row_klass = args.fetch(:row_klass, Sudoku::Row)
      @column_klass = args.fetch(:column_klass, Sudoku::Column)
      @box_klass = args.fetch(:box_klass, Sudoku::Box)
      
      build
    end

    def bad_move( args={} )
      square = args.fetch(:square)
      value = args.fetch(:value)
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
        square = @square_klass.new id: id, board: self
        @squares[id.to_sym] = square
      end
    end
    
    def generate_units
      generate_rows
      generate_columns
      generate_boxes
    end
    
    def generate_rows
      ROW_IDS.each_char do |row_id|
        row = @row_klass.new id: row_id
        COL_IDS.each_char do |col_id|
          row.add_member @squares["#{row_id}#{col_id}".to_sym]
        end
        @rows[row.id.to_sym] = row
        @units << row
      end
    end
  
    def generate_columns
      COL_IDS.each_char do |col_id|
        col = @column_klass.new id: col_id
        ROW_IDS.each_char do |row_id|
          col.add_member @squares["#{row_id}#{col_id}".to_sym]
        end
        @columns[col.id.to_s.to_sym] = col
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
          box.add_member( @squares[member.to_sym] )
        end
        @boxes[(index + 1).to_s.to_sym] = box
        @units << box
      end
    end
  
    def generate_square_peers
      @units.each do |unit|
        unit.members.each do |index, member|
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
