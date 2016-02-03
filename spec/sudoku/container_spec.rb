require 'spec_helper'

RSpec.describe Sudoku::Container do
  describe "#initialize" do
    let(:board) { Sudoku::Board.new }
    
    it "assigns id" do
      column = Sudoku::Container.new( 
        id: 1,
        member_calculator: Sudoku::MemberCalculator::Column.new
      )
      expect(column.id).to eq(1)
    end

    it "assigns board" do
      column = Sudoku::Container.new( board: board )
      expect(column.board).to eq(board)
    end
  end

  describe "#calc_members" do
    it "generates correct square ids for column 1" do
       column = Sudoku::Container.new( 
        id: 1,
        member_calculator: Sudoku::MemberCalculator::Column.new
      )
      expected_squares = [1,10,19,28,37,46,55,64,73]
      expect(column.calc_members).to eq(expected_squares)
    end  
    it "generates correct square ids for column 9" do
       column = Sudoku::Container.new( 
        id: 9,
        member_calculator: Sudoku::MemberCalculator::Column.new
      )
      column.calc_members
      expected_squares = [9,18,27,36,45,54,63,72,81]
      expect(column.calc_members).to eq(expected_squares)
    end
  end

  describe "#get_members" do
    it "sends get_members message to board" do
      board = double()
      column = Sudoku::Container.new( id: 1, board: board )
      expect(board).to receive(:set_container_members).with(column)
      column.get_members
    end
  end

  describe "#add_member" do
    let(:board) { board = double() }
    let(:column) {  column = Sudoku::Container.new( 
        id: 1,
        member_calculator: Sudoku::MemberCalculator::Column.new
      )
    }

    it "adds square to member_squares" do
      square = Sudoku::Square.new( id: 1 )
      column.add_member square: square
      expect(column.member_squares).to include(square)
    end

    context "square not a member of column" do
      it "does not add square" do
       square = Sudoku::Square.new( id: 2 )
       column.add_member square: square
       expect(column.member_squares).to_not include(square)
      end
    end
  end

  describe "#update_peers" do
    let(:column) {  column = Sudoku::Container.new( 
        id: 1,
        member_calculator: Sudoku::MemberCalculator::Column.new
      )
    }
    let(:altered_square) do
       column.calc_members.each do |id|
        column.add_member( square: Sudoku::Square.new( id: id, value: nil ) )
      end
      column.member_squares[1]
    end
    it "should call update on each member square" do
      expect(column.member_squares).to all( 
        receive(:update).with( altered_square ).exactly(1).times 
      )
      column.update_peers( square: altered_square )
    end
    it "should validate altered_square" do
      expect(column).to receive(:validate_square).with( altered_square )
                        .exactly(1).times
      column.update_peers( square: altered_square )
    end
    context "Altered square is not a member of column" do
      it "should not call update on member_squares" do
        expect(column.member_squares).to all(
          receive(:update).with( altered_square ).exactly(0).times
        )
      end
    end
  end
end
