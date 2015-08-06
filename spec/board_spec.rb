require 'spec_helper'

module Sudoku
RSpec.describe Board do

  describe "#square_position" do
    context "with correct parameter" do
      it "should return a corrisponding row, column pair for given value." do
        @row_column_ref = Sudoku::Board.square_position(id: 1)
        expect(@row_column_ref).to eq("r1c1")
      end

      it "should compute last items in a row correctly" do
        @row_column_ref = Sudoku::Board.square_position(id: 18) 
        expect(@row_column_ref).to eq("r2c9")
      end
    end
    
    context "with incorrect parameters" do
      it "should raise an argument error if the id is less than 1." do
        expect{
          @row_column_ref = Sudoku::Board.square_position(id: 0)
        }.to raise_error(ArgumentError)
      end

      it "should raise an argument error if the id is greater than 81" do
        expect{
          @row_column_ref = Sudoku::Board.square_position(id: 82)
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#update_peers" do
    it "should update a given square's peers' possible_values with square's value."
  end

  describe "#find_peers" do
    it "should return an array of peer id's that correspond to given square id."
  end

end
end
