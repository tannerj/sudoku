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

  describe "#update_peers" do
    let(:column) {  column = Container.new( 
        id: 1,
        member_calculator: MemberCalculator::Column.new
      )
    }
    let(:altered_square) do
       column.calc_members.each do |id|
        column.add_member( square: Square.new( id: id, value: nil ) )
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
end
