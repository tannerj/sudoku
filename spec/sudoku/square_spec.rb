require 'spec_helper'

RSpec.describe Sudoku::Square do
  describe "#initialize" do
    context "with correct parameters" do
      it "should accept an id" do
        @square = Sudoku::Square.new(id: 1, value: 9)
       expect(@square.id).to eq(1)
      end

      it "should accept a value" do
        @square = Sudoku::Square.new(id: 1, value: 9)
        expect(@square.value).to eq(9)
      end

      it "does not require a value" do
        expect{
          @square = Sudoku::Square.new(id: 1) 
        }.not_to raise_error
      end

      it "returns nil for value if no value is given during initialization" do
        @square = Sudoku::Square.new(id: 1)
        expect(@square.value).to eq(nil)
      end

      it "creates an array of possible values if no value is given" do
        @square = Sudoku::Square.new(id: 1)
        expect(@square.possible_values).to match_array((1..9).to_a)
      end

      it "sets possible_values to one item array of value if value given" do
        @square = Sudoku::Square.new(id: 1, value: 9)
        expect(@square.possible_values).to match_array([9])
      end
    end

    context "with incorrect parameters" do
      it "should raise an argument error execption without an id" do
        expect{
          @square = Sudoku::Square.new(value: 9)
          }.to raise_error(ArgumentError)
      end

      it "should raise an agrument error if id is less than 1" do
        expect{
          @square = Sudoku::Square.new(id: -1, value: 9) 
        }.to raise_error(ArgumentError)
      end

      it "should raise an argument error if id is greater than 81" do
        expect{
          @square = Sudoku::Square.new(id: 82, value: 9) 
        }.to raise_error(ArgumentError)
      end

      it "should raise an argument error if value is less than 1." do
        expect{
          @square = Sudoku::Square.new(id: 1, value: 0)
        }.to raise_error(ArgumentError)
      end

      it "should raise an argument error if value is greater than 9" do
        expect{
          @square = Sudoku::Square.new(id: 1, value: 10)
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#value=" do
    let(:square) { $square = Sudoku::Square.new( id: 1 )}
    context "with correct params" do
      it "should set the value" do
        square
        square.value = 1
        expect(square.value).to eq(1)
      end

      it "should call board.update_peers" do
        @board = double()
        @square = Sudoku::Square.new(id: 1, board: @board)
        expect(@board).to receive(:update_peers).with(@square)
        @square.value = 1
      end

      it "should set square#possible_values tp signle item array of value" do
        square
        square.value = 1
        expect(square.possible_values).to match_array([1])
      end
    end

    context "with incorrect params" do
      it "should raise ValueOutOfBoundsError if value is less than 1" do
        @square = Sudoku::Square.new(id: 1)
        expect{
          @square.value = 0
        }.to raise_error(Sudoku::ValueOutOfBoundsError)
      end

      it "should raise ValueOutOfBoundsError if value is greater than 9" do
        @square = Sudoku::Square.new(id: 1)
        expect{
          @square.value = 10
        }.to raise_error(Sudoku::ValueOutOfBoundsError)
      end
    end
  end

  describe "#update" do
    it "should search possible_values for given square's value and remove it from array." do
      @square_to_be_updated = Sudoku::Square.new(id: 1)
      @peer_square = Sudoku::Square.new(id: 2, value: 9)
      @square_to_be_updated.update(@peer_square)
      expect(@square_to_be_updated.possible_values).to match_array((1..8).to_a)
    end
    
    it "should do nothing if given square's value is nil" do
      @square_to_be_updated = Sudoku::Square.new(id: 1)
      @peer_square = Sudoku::Square.new(id: 2)
      @square_to_be_updated.update(@peer_square)
      expect(@square_to_be_updated.possible_values).to match_array((1..9).to_a)
    end

    it "should update value if possible_values has a length of 1" do
      @square_to_be_updated = Sudoku::Square.new(id: 1)
      (2..9).each do | value |
        @square_to_be_updated.update(Sudoku::Square.new id: value, value: value)
      end
      expect(@square_to_be_updated.value).to eq(1)
    end

    it "sends illegal_move message to board if all possible_values are removed" do
      @board = double()
      @square = Sudoku::Square.new(id: 1, value: 9, board: @board)
      @illegal_peer = Sudoku::Square.new(id: 2, value: 9)
      expect(@board).to receive(:illegal_move).with(@illegal_peer)
      @square.update @illegal_peer
    end
  end

  describe "#update_peers" do
    it "should send update_peers message on board object, passing self." do
      @board = double()
      @square = Sudoku::Square.new(id: 1, value: 2, board: @board)
      expect(@board).to receive(:update_peers).with(@square)
      @square.update_peers
    end
  end
end
