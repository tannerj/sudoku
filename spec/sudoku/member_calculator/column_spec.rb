require 'spec_helper'

module Sudoku
module MemberCalculator
RSpec.describe Column do

  describe "#calc_members" do
    it "generates correct square ids for column 1" do
       column = ::Sudoku::Container.new( 
        id: 1,
        member_calculator: Column.new
      )
      expected_squares = [1,10,19,28,37,46,55,64,73]
      expect(column.calc_members).to eq(expected_squares)
    end
    it "generates correct square ids for column 2" do
       column = ::Sudoku::Container.new( 
        id: 2,
        member_calculator: Column.new
      )
      expected_squares = [2,11,20,29,38,47,56,65,74]
      expect(column.calc_members).to eq(expected_squares)
    end
it "generates correct square ids for column 3" do
       column = ::Sudoku::Container.new( 
        id: 3,
        member_calculator: Column.new
      )
      expected_squares = [3,12,21,30,39,48,57,66,75]
      expect(column.calc_members).to eq(expected_squares)
    end
    it "generates correct square ids for column 4" do
       column = ::Sudoku::Container.new( 
        id: 4,
        member_calculator: Column.new
      )
      expected_squares = [4,13,22,31,40,49,58,67,76]
      expect(column.calc_members).to eq(expected_squares)
    end    
    it "generates correct square ids for column 5" do
       column = ::Sudoku::Container.new( 
        id: 5,
        member_calculator: Column.new
      )
      expected_squares = [5,14,23,32,41,50,59,68,77]
      expect(column.calc_members).to eq(expected_squares)
    end    
    it "generates correct square ids for column 6" do
       column = ::Sudoku::Container.new( 
        id: 6,
        member_calculator: Column.new
      )
      expected_squares = [6,15,24,33,42,51,60,69,78]
      expect(column.calc_members).to eq(expected_squares)
    end    
    it "generates correct square ids for column 7" do
       column = ::Sudoku::Container.new( 
        id: 7,
        member_calculator: Column.new
      )
      expected_squares = [7,16,25,34,43,52,61,70,79]
      expect(column.calc_members).to eq(expected_squares)
    end    
    it "generates correct square ids for column 8" do
       column = ::Sudoku::Container.new( 
        id: 8,
        member_calculator: Column.new
      )
      expected_squares = [8,17,26,35,44,53,62,71,80]
      expect(column.calc_members).to eq(expected_squares)
    end
    it "generates correct square ids for column 9" do
       column = ::Sudoku::Container.new( 
        id: 9,
        member_calculator: Column.new
      )
      column.calc_members
      expected_squares = [9,18,27,36,45,54,63,72,81]
      expect(column.calc_members).to eq(expected_squares)
    end
  end
end
end
end
