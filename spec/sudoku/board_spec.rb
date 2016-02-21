require 'spec_helper'

module Sudoku
RSpec.describe Board do

  describe "#create" do
    let(:square) { $square = Square }
    let(:game) { $game = Game }
    let(:square_values) { (1..81).to_a.map! {|x| x = "0"}.join }
    let(:board) do
      $board = Board.create(
        square_values: square_values,
        square: square,
        game: game
      )
    end
    let(:column_1_ids) { [1, 10, 19, 28, 37, 46, 55, 64, 73] }
    let(:column_9_ids) { [9, 18, 27, 36, 45, 54, 63, 72, 81] }
    let(:row_1_ids) { [1, 2, 3, 4, 5, 6, 7, 8, 9] }
    let(:row_9_ids) { [73, 74, 75, 76, 77, 78,  79, 80, 81] }
    let(:box_1_ids) { [1, 2, 3, 10, 11, 12, 19, 20, 21] }
    let(:box_9_ids) { [61, 62, 63, 70, 71, 72, 79, 80, 81] }

    it "should call Sudoku::Square.create 81 times" do
      expect(square).to receive(:new).exactly(81).times
      board
    end

    it "should load board#squares with 81 square instances" do
      board
      #board.squares[0] is nil to match indexes with square ids
      expect(board.squares.length).to eq(82)
    end

    it "should set column one members correctly" do
      board_column_ids = []
      board.columns[1].member_squares.each do |square|
        if !square.nil?
          board_column_ids << square.id
        end
      end
      expect(board_column_ids).to eq(column_1_ids)
    end

    it "should set column nine members correctly" do
      board_column_ids = []
      board.columns[9].member_squares.each do |square|
        if !square.nil?
          board_column_ids << square.id
        end
      end
      expect(board_column_ids).to eq(column_9_ids)
    end

    it "should set row one members correctly" do
      board_row_ids = []
      board.rows[1].member_squares.each do |square|
        if !square.nil?
          board_row_ids << square.id
        end
      end
      expect(board_row_ids).to eq(row_1_ids)
    end
    
    it "should set row nine members correctly" do
      board_row_ids = []
      board.rows[9].member_squares.each do |square|
        if !square.nil?
          board_row_ids << square.id
        end
      end
      expect(board_row_ids).to eq(row_9_ids)
    end
    
    it "should set box one members correctly" do
      board_box_ids = []
      board.boxes[1].member_squares.each do |square|
        if !square.nil?
          board_box_ids << square.id
        end
      end
      expect(board_box_ids).to eq(box_1_ids)
    end    
    
    it "should set box nine members correctly" do
      board_box_ids = []
      board.boxes[9].member_squares.each do |square|
        if !square.nil?
          board_box_ids << square.id
        end
      end
      expect(board_box_ids).to eq(box_9_ids)
    end
  end

  describe "#square_position" do
    context "with correct parameter" do
      it "should return a corrisponding row, column pair for given value." do
        @row_column_ref = Board.square_position(id: 1)
        expect(@row_column_ref).to eq("r1c1")
      end

      it "should compute last items in a row correctly" do
        @row_column_ref = Board.square_position(id: 18) 
        expect(@row_column_ref).to eq("r2c9")
      end
    end
    
    context "with incorrect parameters" do
      it "should raise an argument error if the id is less than 1." do
        expect{
          @row_column_ref = Board.square_position(id: 0)
        }.to raise_error(ArgumentError)
      end

      it "should raise an argument error if the id is greater than 81" do
        expect{
          @row_column_ref = Board.square_position(id: 82)
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#update_square" do
    let(:square_values) { (1..81).to_a.map! {|x| x = "0"}.join }
    let(:square) { Square }
    let(:game) { Game }
    let(:board) do
      Board.create(
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
    let(:board) { Board.create(
        square_values: (1..81).to_a.map! { |x| "0" }.join
      )
    }
    let(:square) { board.squares[1] }
    let(:peer_ids) {
      peer_ids = [
                   2, 3, 4, 5, 6, 7, 8, 9,
                   10, 11, 12, 19, 20, 21,
                   28, 37, 46, 55, 64, 73
                 ]
    }
    let(:expected_peer_possible_values) {
      [ 2, 3, 4, 5, 6, 7, 8, 9 ]
    }
    let(:expected_non_peer_possible_values) { (1..9).to_a  }
    it "should update each peer" do
      board.squares[1].value = 1 # This calls board.update_peers
      peer_possible_values = []
      board.squares.each do |square|
        if peer_ids.include? square.id
          peer_possible_values << square.possible_values
        end
      end
      expect(peer_possible_values)
        .to all( match_array( expected_peer_possible_values ) )
    end
    it "should not update non-peers" do
      board.squares[1].value = 1 # This calls board.update_peers
      non_peer_possible_values = []
      board.squares.each_with_index do |square, index|
        # square 1 is what we've updated it is not a peer,
        # nor a non-peer, we'll just skip it.
        # We also have to skip the square at index zero,
        # it's a null object.
        next if [0, 1].include? index
        if !peer_ids.include? square.id
          non_peer_possible_values << square.possible_values
        end
      end
      expect(non_peer_possible_values)
        .to all( match_array( expected_non_peer_possible_values ) )
    end
  end

  describe "#set_container_members" do
    let(:board) { Board.create(
        square_values: (1..81).to_a.map! { |x| x = "0" }.join
      )
    }
    it "sets container.member_squares" do
      board
      container = Container.new( 
        id: 1, 
        member_calculator: MemberCalculator::Column.new, 
        board: board
      )
      expected_members = board.squares.select do |square|
        [1, 10, 19, 28, 37, 46, 55, 64, 73].include? square.id
      end
      board.set_container_members container
      expect(container.member_squares).to match_array(expected_members)
    end
  end

  describe "#illegal_move" do
    let(:board) { Board.create(
        square_values: (1..81).to_a.map! { |x| x = "0" }.join
      )
    }
    it "should respond to #illegal_move" do
      expect(board).to respond_to(:illegal_move)
    end
  end
end
end
