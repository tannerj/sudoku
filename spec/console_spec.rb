require 'spec_helper'

module Sudoku
RSpec.describe Console do
  describe "#render_board" do
    it "should draw an empty board if no squares have value" do
      @board = Sudoku::Board.new()
      empty_board = [
        %q[     1 2 3   4 5 6   7 8 9 ],
        %q[   .-------.-------.-------. ],
        %q[A  | . . . | . . . | . . . | ],
        %q[B  | . . . | . . . | . . . | ],
        %q[C  | . . . | . . . | . . . | ],
        %q[   :------- ------- -------: ],
        %q[D  | . . . | . . . | . . . | ],
        %q[E  | . . . | . . . | . . . | ],
        %q[F  | . . . | . . . | . . . | ],
        %q[   :------- ------- -------: ],
        %q[G  | . . . | . . . | . . . | ],
        %q[H  | . . . | . . . | . . . | ],
        %q[I  | . . . | . . . | . . . | ],
        %q[   '-------'-------'-------' ]
      ].join("\n")
      expect(@board.draw).to eq(empty_board)
    end
    it "it should draw a square with it's value if a value exists."
  end
end
