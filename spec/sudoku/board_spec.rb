require 'spec_helper'

module Sudoku
RSpec.describe Board do

  describe "#create" do
    let(:square) { $square = Sudoku::Square }
    let(:game) { $game = Sudoku::Game }
    let(:square_values) { (1..81).to_a.map! {|x| x = "0"}.join }
    let(:board) do
      $board = Sudoku::Board.create(
        square_values: square_values,
        square: square,
        game: game
      )
    end

    it "should call Sudoku::Square.create 81 times" do
      expect(square).to receive(:new).exactly(81).times
      board
    end

    it "should load baard#squares with 81 square instances" do
      board
      #board.squares[0] is nil to match indexes with square ids
      expect(board.squares.length).to eq(82)
    end
  end

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

  describe "#update_square" do
    let(:square_values) { (1..81).to_a.map! {|x| x = "0"}.join }
    let(:square) { Sudoku::Square }
    let(:game) { Sudoku::Game }
    let(:board) do
      Sudoku::Board.create(
        square_values: square_values,
        square: square,
        game: game
      )
    end
    before(:each) do
      board 
    end
    context "with correct params" do
      it "should update a square given it's id and a value." do
        board.update_square id: 1, value: 9
        expect(board.squares[1].value).to eq(9)
      end
    end
    context "with incorrect params" do
      it "should rescue valueoutofbounds error from square" do
        expect {
          board.update_square id: 1, value: 10
        }.to_not raise_error

      end
    end
  end

  describe "#update_peers" do
    it "should update a given square's peers' possible_values with square's value."
  end

  describe "#find_peers" do
    let(:peer_ids) do
      $peer_ids = [1,2,3,4,5,6,7,8,9,10,11,12,19,20,21,28,37,46,55,64,73]
    end
    let(:square) { Sudoku::Square.new id: 1, value: nil }
    let(:updated_square_value) { 1 }
    let(:square_values) { (1..81).to_a.map! {|x| x = "0" }.join }
    let(:game) { Sudoku::Game }
    let(:board) do
      Sudoku::Board.create(
        square_values: square_values,
        square: square,
        game: game
      )
    end
    xit "should return an array of peer id's that correspond to given square id." do
      board
      expect(board.find_peers(square)).to match_array(peer_ids)
    end
  end

  describe "#set_container_members" do
    let(:board) { Sudoku::Board.create(
        square_values: (1..81).to_a.map! { |x| x = "0" }.join
      )
    }
    it "sets container.member_squares" do
      board
      container = Sudoku::Container.new id: 1, member_calculator: Sudoku::Column.new, board: board
      expected_members = board.squares.select do |square|
        [1, 10, 19, 28, 37, 46, 55, 64, 73].include? square.id
      end
      board.set_container_members container
      expect(container.member_squares).to match_array(expected_members)
    end
  end
end
end
