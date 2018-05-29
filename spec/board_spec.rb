require 'spec_helper'

RSpec.describe Sudoku::Board do
  let(:board) { Sudoku::Board.new }
  let(:square_ids) do
    [
      :A1, :A2, :A3, :A4, :A5, :A6, :A7, :A8, :A9,
      :B1, :B2, :B3, :B4, :B5, :B6, :B7, :B8, :B9,
      :C1, :C2, :C3, :C4, :C5, :C6, :C7, :C8, :C9, 
      :D1, :D2, :D3, :D4, :D5, :D6, :D7, :D8, :D9,
      :E1, :E2, :E3, :E4, :E5, :E6, :E7, :E8, :E9, 
      :F1, :F2, :F3, :F4, :F5, :F6, :F7, :F8, :F9,
      :G1, :G2, :G3, :G4, :G5, :G6, :G7, :G8, :G9,
      :H1, :H2, :H3, :H4, :H5, :H6, :H7, :H8, :H9,
      :I1, :I2, :I3, :I4, :I5, :I6, :I7, :I8, :I9
    ]
  end
  let(:row_ids) do
    [
      [],
      [:A1, :A2, :A3, :A4, :A5, :A6, :A7, :A8, :A9],
      [:B1, :B2, :B3, :B4, :B5, :B6, :B7, :B8, :B9],
      [:C1, :C2, :C3, :C4, :C5, :C6, :C7, :C8, :C9], 
      [:D1, :D2, :D3, :D4, :D5, :D6, :D7, :D8, :D9],
      [:E1, :E2, :E3, :E4, :E5, :E6, :E7, :E8, :E9], 
      [:F1, :F2, :F3, :F4, :F5, :F6, :F7, :F8, :F9],
      [:G1, :G2, :G3, :G4, :G5, :G6, :G7, :G8, :G9],
      [:H1, :H2, :H3, :H4, :H5, :H6, :H7, :H8, :H9],
      [:I1, :I2, :I3, :I4, :I5, :I6, :I7, :I8, :I9]
    ]
  end
  let(:col_ids) do
    [
      [],
      [:A1, :B1, :C1, :D1, :E1, :F1, :G1, :H1, :I1],
      [:A2, :B2, :C2, :D2, :E2, :F2, :G2, :H2, :I2],
      [:A3, :B3, :C3, :D3, :E3, :F3, :G3, :H3, :I3],
      [:A4, :B4, :C4, :D4, :E4, :F4, :G4, :H4, :I4],
      [:A5, :B5, :C5, :D5, :E5, :F5, :G5, :H5, :I5],
      [:A6, :B6, :C6, :D6, :E6, :F6, :G6, :H6, :I6],
      [:A7, :B7, :C7, :D7, :E7, :F7, :G7, :H7, :I7],
      [:A8, :B8, :C8, :D8, :E8, :F8, :G8, :H8, :I8],
      [:A9, :B9, :C9, :D9, :E9, :F9, :G9, :H9, :I9],
    ]
  end
  let(:box_ids) do
    [
      [],
      [:A1, :A2, :A3, :B1, :B2, :B3, :C1, :C2, :C3],
      [:A4, :A5, :A6, :B4, :B5, :B6, :C4, :C5, :C6],
      [:A7, :A8, :A9, :B7, :B8, :B9, :C7, :C8, :C9],
      [:D1, :D2, :D3, :E1, :E2, :E3, :F1, :F2, :F3],
      [:D4, :D5, :D6, :E4, :E5, :E6, :F4, :F5, :F6],
      [:D7, :D8, :D9, :E7, :E8, :E9, :F7, :F8, :F9],
      [:G1, :G2, :G3, :H1, :H2, :H3, :I1, :I2, :I3],
      [:G4, :G5, :G6, :H4, :H5, :H6, :I4, :I5, :I6],
      [:G7, :G8, :G9, :H7, :H8, :H9, :I7, :I8, :I9],
    ]
  end

  describe "square generation" do
    it "correctly hashes squares by id" do
      expect(board.squares.keys).to match_array(square_ids)
    end
    it "correctly assigns id and board to created squares" do
      square_klass = class_double("Sudoku::Square")
      allow(square_klass).to receive(:new) do |args|
        square = double(
          "Sudoku::Square",
          id: args.fetch(:id),
          board: args.fetch(:board)
        )
        allow(square).to receive(:add_peers)
        square
      end
      board = Sudoku::Board.new(square_klass: square_klass)
      
      expect(square_klass).to have_received(:new).with(hash_including(board: board)).exactly(81).times
    end
  end

  describe "row generation" do
    it "creates 9 rows" do
      row_klass = class_double("Sudoku::Row") 
      allow(row_klass).to receive(:new) do |args|
        row = double("Sudoku::Row", id: args.fetch(:id))
        allow(row).to receive(:members).and_return({})
        allow(row).to receive(:add_member).and_return(true)
        row
      end
      expect(row_klass).to receive(:new).exactly(9).times

      board = Sudoku::Board.new(row_klass: row_klass)
    end
    it "Assigns correct squares" do
      expect(board.rows[:A].members.keys).to match_array(row_ids[1]) 
      expect(board.rows[:B].members.keys).to match_array(row_ids[2]) 
      expect(board.rows[:C].members.keys).to match_array(row_ids[3]) 
      expect(board.rows[:D].members.keys).to match_array(row_ids[4]) 
      expect(board.rows[:E].members.keys).to match_array(row_ids[5]) 
      expect(board.rows[:F].members.keys).to match_array(row_ids[6]) 
      expect(board.rows[:G].members.keys).to match_array(row_ids[7]) 
      expect(board.rows[:H].members.keys).to match_array(row_ids[8]) 
      expect(board.rows[:I].members.keys).to match_array(row_ids[9]) 
    end
    it "Adds rows to Sudoku::Board#units" do
      expect(board.units).to include(
        kind_of(Sudoku::Row),
        kind_of(Sudoku::Row),
        kind_of(Sudoku::Row),
        kind_of(Sudoku::Row),
        kind_of(Sudoku::Row),
        kind_of(Sudoku::Row),
        kind_of(Sudoku::Row),
        kind_of(Sudoku::Row),
        kind_of(Sudoku::Row)
      )
    end
  end
  describe "column generation" do
    it "creates 9 columns" do
      col_klass = class_double("Sudoku::Column") 
      allow(col_klass).to receive(:new) do |args|
        col = double("Sudoku::Column", id: args.fetch(:id))
        allow(col).to receive(:members).and_return({})
        allow(col).to receive(:add_member).and_return(true)
        col
      end
      expect(col_klass).to receive(:new).exactly(9).times

      board = Sudoku::Board.new(column_klass: col_klass)
    end
    it "Assigns correct squares" do
      expect(board.columns[:"1"].members.keys).to match_array(col_ids[1]) 
      expect(board.columns[:"2"].members.keys).to match_array(col_ids[2]) 
      expect(board.columns[:"3"].members.keys).to match_array(col_ids[3]) 
      expect(board.columns[:"4"].members.keys).to match_array(col_ids[4]) 
      expect(board.columns[:"5"].members.keys).to match_array(col_ids[5]) 
      expect(board.columns[:"6"].members.keys).to match_array(col_ids[6]) 
      expect(board.columns[:"7"].members.keys).to match_array(col_ids[7]) 
      expect(board.columns[:"8"].members.keys).to match_array(col_ids[8]) 
      expect(board.columns[:"9"].members.keys).to match_array(col_ids[9]) 
    end
    it "Adds rows to Sudoku::Board#units" do
      expect(board.units).to include(
        kind_of(Sudoku::Column),
        kind_of(Sudoku::Column),
        kind_of(Sudoku::Column),
        kind_of(Sudoku::Column),
        kind_of(Sudoku::Column),
        kind_of(Sudoku::Column),
        kind_of(Sudoku::Column),
        kind_of(Sudoku::Column),
        kind_of(Sudoku::Column)
      )
    end
  end
  describe "box generation" do
    it "creates 9 boxes" do
      box_klass = class_double("Sudoku::Box") 
      allow(box_klass).to receive(:new) do |args|
        box = double("Sudoku::Box", id: args.fetch(:id))
        allow(box).to receive(:members).and_return({})
        allow(box).to receive(:add_member).and_return(true)
        box
      end
      expect(box_klass).to receive(:new).exactly(9).times

      board = Sudoku::Board.new(box_klass: box_klass)
    end
    it "Assigns correct squares" do
      expect(board.boxes[:"1"].members.keys).to match_array(box_ids[1]) 
      expect(board.boxes[:"2"].members.keys).to match_array(box_ids[2]) 
      expect(board.boxes[:"3"].members.keys).to match_array(box_ids[3]) 
      expect(board.boxes[:"4"].members.keys).to match_array(box_ids[4]) 
      expect(board.boxes[:"5"].members.keys).to match_array(box_ids[5]) 
      expect(board.boxes[:"6"].members.keys).to match_array(box_ids[6]) 
      expect(board.boxes[:"7"].members.keys).to match_array(box_ids[7]) 
      expect(board.boxes[:"8"].members.keys).to match_array(box_ids[8]) 
      expect(board.boxes[:"9"].members.keys).to match_array(box_ids[9]) 
    end
    it "Adds rows to Sudoku::Board#units" do
      expect(board.units).to include(
        kind_of(Sudoku::Box),
        kind_of(Sudoku::Box),
        kind_of(Sudoku::Box),
        kind_of(Sudoku::Box),
        kind_of(Sudoku::Box),
        kind_of(Sudoku::Box),
        kind_of(Sudoku::Box),
        kind_of(Sudoku::Box),
        kind_of(Sudoku::Box)
      )
    end
  end

  it "Adds each square's peers" do
    expected_a1_peer_ids = [
      [:A2, :A3, :A4, :A5, :A6, :A7, :A8, :A9],
      [:B1, :C1, :D1, :E1, :F1, :G1, :H1, :I1],
      [:A2, :A3, :B1, :B2, :B3, :C1, :C2, :C3],
    ].flatten.uniq
    a1_peer_ids = []
    board.squares[:A1].peers.each do |peer|
      a1_peer_ids << peer.id.to_sym
    end
    expect(a1_peer_ids).to match_array(expected_a1_peer_ids) 
  end
end
