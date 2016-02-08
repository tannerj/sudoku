require 'spec_helper'

module Sudoku
module MemberCalculator
RSpec.describe Box do
  
  describe "#calc_members" do
    it "should return correct members for box 1" do
      box = ::Sudoku::Container.new(
        id: 1,
        member_calculator: Box.new
      )
      expected_squares = [1,2,3,10,11,12,19,20,21]
      expect(box.calc_members).to match_array(expected_squares)
    end
    it "should return correct members for box 2" do
      box = ::Sudoku::Container.new(
        id: 2,
        member_calculator: Box.new
      )
      expected_squares = [4,5,6,13,14,15,22,23,24]
      expect(box.calc_members).to match_array(expected_squares)
    end
    it "should return correct members for box 3" do
      box = ::Sudoku::Container.new(
        id: 3,
        member_calculator: Box.new
      )
      expected_squares = [7,8,9,16,17,18,25,26,27]
      expect(box.calc_members).to match_array(expected_squares)
    end
    it "should return correct members for box 4" do
      box = ::Sudoku::Container.new(
        id: 4,
        member_calculator: Box.new
      )
      expected_squares = [28,29,30,37,38,39,46, 47,48]
      expect(box.calc_members).to match_array(expected_squares)
    end
    it "should return correct members for box 5" do
      box = ::Sudoku::Container.new(
        id: 5,
        member_calculator: Box.new
      )
      expected_squares = [31, 32, 33, 40, 41, 42, 49, 50 ,51]
      expect(box.calc_members).to match_array(expected_squares)
    end
    it "should return correct members for box 6" do
      box = ::Sudoku::Container.new(
        id: 6,
        member_calculator: Box.new
      )
      expected_squares = [34, 35, 36, 43, 44, 45, 52, 53, 54]
      expect(box.calc_members).to match_array(expected_squares)
    end
    it "should return correct members for box 7" do
      box = ::Sudoku::Container.new(
        id: 7,
        member_calculator: Box.new
      )
      expected_squares = [55, 56, 57, 64, 65, 66, 73, 74, 75]
      expect(box.calc_members).to match_array(expected_squares)
    end
    it "should return correct members for box 8" do
      box = ::Sudoku::Container.new(
        id: 8,
        member_calculator: Box.new
      )
      expected_squares = [58, 59, 60, 67, 68, 69, 76, 77, 78]
      expect(box.calc_members).to match_array(expected_squares)
    end
    it "should return correct members for box 9" do
      box = ::Sudoku::Container.new(
        id: 9,
        member_calculator: Box.new
      )
      expected_squares = [61, 62, 63, 70, 71, 72, 79, 80, 81]
      expect(box.calc_members).to match_array(expected_squares)
    end
  end

  describe "#set_square_container" do
    let(:member_calculator) { ::Sudoku::MemberCalculator::Box.new }
    let(:box) { ::Sudoku::Container.new(
      id: 1,
      member_calculator: member_calculator
    )}
    let(:square) { ::Sudoku::Square.new( id: 1 ) }
    it "should set square's box" do
      box
      member_calculator.set_square_container( square )
      expect(square.box).to eq( box )
    end
    context "square is not a container member" do
      let(:square) { ::Sudoku::Square.new( id: 2 ) }
      it "should not set square's box" do
        member_calculator.set_square_container( square )
        expect(square.box).to_not eq( box )
      end
    end
  end
end
end
end
