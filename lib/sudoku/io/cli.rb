module Sudoku
  module IO
    module CLI
      
      def self.render_board( board )
        col_headers = "    1   2   3   4   5   6   7   8   9  \n"
        row_spacer =  "  +---+---+---+---+---+---+---+---+---+\n"
        output = col_headers + row_spacer
        board.rows.each do |index, row|
          row_output = "#{row.id} |"
          row.members.each do |index, member|
            row_output += " #{member.value} |"
          end
          row_output += "\n"
          output += row_output + row_spacer
        end
        puts "#{output}"
      end
    end
  end
end

