require 'spec_helper'

module Sudoku
module MemberCalculator
RSpec.describe Row do
  
  describe "#calc_members" do
    it "should return the correct members for row 1" do
        row = ::Sudoku::Container.new( 
        id: 1,
        member_calculator: Row.new
      )
      expected_squares = [1,2,3,4,5,6,7,8,9]
      expect(row.calc_members).to eq(expected_squares)
    end    
    it "should return the correct members for row 2" do
        row = ::Sudoku::Container.new( 
        id: 2,
        member_calculator: Row.new
      )
      expected_squares = [10,11,12,13,14,15,16,17,18]
      expect(row.calc_members).to eq(expected_squares)
    end
    it "should return the correct members for row 3" do
      row = ::Sudoku::Container.new(
        id: 3,
        member_calculator: Row.new
      )
      expected_squares = [19,20,21,22,23,24,25,26,27]
      expect(row.calc_members).to eq(expected_squares)
    end
    it "should return the correct members for row 4" do
      row = ::Sudoku::Container.new(
        id: 4,
        member_calculator: Row.new
      )
      expected_squares = [28,29,30,31,32,33,34,35,36]
      expect(row.calc_members).to eq(expected_squares)
    end
    it "should return the correct members for row 5" do
      row = ::Sudoku::Container.new(
        id: 5,
        member_calculator: Row.new
      )
      expected_squares = [37,38,39,40,41,42,43,44,45]
      expect(row.calc_members).to eq(expected_squares)
    end
    it "should return the correct members for row 6" do
      row = ::Sudoku::Container.new(
        id: 6,
        member_calculator: Row.new
      )
      expected_squares = [46,47,48,49,50,51,52,53,54]
      expect(row.calc_members).to eq(expected_squares)
    end
    it "should return the correct members for row 7" do
      row = ::Sudoku::Container.new(
        id: 7,
        member_calculator: Row.new
      )
      expected_squares = [55,56,57,58,59,60,61,62,63]
      expect(row.calc_members).to eq(expected_squares)
    end
    it "should return the correct members for row 8" do
      row = ::Sudoku::Container.new(
        id: 8,
        member_calculator: Row.new
      )
      expected_squares = [64,65,66,67,68,69,70,71,72]
      expect(row.calc_members).to eq(expected_squares)
    end
    it "should return the correct members for row 89" do
      row = ::Sudoku::Container.new(
        id: 9,
        member_calculator: Row.new
      )
      expected_squares = [73,74,75,76,77,78,79,80,81]
      expect(row.calc_members).to eq(expected_squares)
    end
  end  
  
  describe "#set_square_container" do
    let(:member_calculator) { ::Sudoku::MemberCalculator::Row.new }
    let(:row) { ::Sudoku::Container.new(
      id: 1,
      member_calculator: member_calculator
    )}
    let(:square) { ::Sudoku::Square.new( id: 1 ) }
    it "should set square's row" do
      row 
      member_calculator.set_square_container( square )
      expect(square.row).to eq( row )
    end
    context "square is not a container member" do
      let(:square) { ::Sudoku::Square.new( id: 2 ) }
      it "should not set square's row" do
        member_calculator.set_square_container( square )
        expect(square.row).to_not eq( row)
      end
    end
  end

end
end
end
