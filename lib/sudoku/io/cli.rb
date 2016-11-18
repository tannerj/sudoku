module Sudoku
  module IO
    module CLI
      
      def self.render_board( args={})
        board = args.fetch(:board)
        col_headers = "    1   2   3   4   5   6   7   8   9  \n"
        row_spacer =  "  +... ... ...+... ... ...+... ... ...+\n"
        box_spacer =  "  +---+---+---+---+---+---+---+---+---+\n"
        output = col_headers + box_spacer
        row_counter = 1
        column_counter = 1
        square_border = ":"
        box_border = "|"
        board.rows.each do |index, row|
          row_output = "#{row.id} |"
          row.members.each do |index, member|
            border = ( column_counter == 3 ) ? box_border : square_border
            row_output += (member.value != 0) ? " #{member.value} #{border}" : "   #{border}"
            column_counter = 0 if column_counter == 3
            column_counter += 1
          end
          row_output += "\n"
          if row_counter == 3
            output += row_output + box_spacer
          else
            output += row_output + row_spacer
          end
          row_counter = 0 if row_counter == 3
          row_counter += 1
        end
        puts "#{output}"
      end
    end
  end
end
