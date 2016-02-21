require 'spec_helper'

module Sudoku
RSpec.describe Container do
  describe "#initialize" do
    let(:board) { NullBoard.new }
    let(:member_calculator) { Sudoku::MemberCalculator::Column.new }
    let(:column) { Container.new(
      id: 1,
      member_calculator: member_calculator,
      board: board
    )}
    it "assigns id" do
      column
      expect(column.id).to eq(1)
    end

    it "#assigns board" do
      column
      expect(column.board).to eq(board)
    end

    it "#sets container for member_calculator" do
      column
      expect(member_calculator.container).to eq(column)
    end
  end

  describe "#calc_members" do
    it "should call calc_members on member_calculator" do
      member_calculator = MemberCalculator::Column.new
      column = Container.new(
        id: 1,
        member_calculator: member_calculator
      )
      expect(member_calculator).to receive(:calc_members).with(column)
      column.calc_members
    end
  end

  describe "#get_members" do
    it "sends get_members message to board" do
      board = double()
      column = Container.new( 
        id: 1, 
        member_calculator: MemberCalculator::Column.new,
        board: board )
      expect(board).to receive(:set_container_members).with(column)
      column.get_members
    end
  end

  describe "#add_member" do
    let(:board) { board = double() }
    let(:column) {  column = Container.new( 
        id: 1,
        member_calculator: MemberCalculator::Column.new
      )
    }

    it "adds square to member_squares" do
      square = Square.new( id: 1 )
      column.add_member square: square
      expect(column.member_squares).to include(square)
    end

    context "square not a member of column" do
      it "does not add square" do
       square = Square.new( id: 2 )
       column.add_member square: square
       expect(column.member_squares).to_not include(square)
      end
    end
  end

  describe "#update" do
    let(:board) { NullBoard.new }
    let(:column) {  column = Container.new( 
        id: 1,
        member_calculator: MemberCalculator::Column.new,
        board: board
      )
    }
    let(:member_square) do
       column.calc_members.each do |id|
        column.add_member( square: Square.new( id: id, value: nil ) )
      end
      column.member_squares[1]
    end
    let(:altered_square) { Square.new( id: 1, value: 1 )}
    it "should call update on each member square" do
      expect(column.member_squares).to all( 
        receive(:update).with( member_square ).exactly(1).times 
      )
      column.update( square: member_square )
    end
    it "should validate altered_square" do
      expect(column).to receive(:validate_square).with( member_square )
                        .exactly(1).times
      column.update( square: member_square )
    end
    it "should update possible_values" do
      column.update( square: altered_square )
      expect(column.possible_values).to match_array( (2..9).to_a )
    end
    context "Altered square is not a member of column" do
      it "should not call update on member_squares" do
        expect(column.member_squares).to all(
          receive(:update).with( member_square ).exactly(0).times
        )
      end
    end
    context "Altered square is set to value that is not possible" do
      it "sends #illegal_move to Board" do
        member_square.value = 1
        column.update( square: member_square )
        second_member = column.member_squares[1]
        second_member.value = 1
        expect(board).to receive(:illegal_move)
        column.update( square: second_member)
      end
    end
  end
end
end
