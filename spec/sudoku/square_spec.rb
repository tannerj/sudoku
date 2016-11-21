require 'spec_helper'

RSpec.describe Sudoku::Square do
  let( :board ) { spy( 'board' ) }  
  let( :peer ) { spy( 'peer', id: 'A2', value: 4, board: board ) } 
  let( :non_peer ) { spy( 'peer', id: 'D4', value: 4, board: board ) }
  let( :square ) { Sudoku::Square.new id: 'A1', value: 5, board: board }
  
  describe "initialization" do
    it "should accept a value" do
      expect( square.value ).to eq(5)
    end

    it "should accept an id" do
      expect( square.id ).to eq('A1')
    end
  end

  describe "#add_peers" do
    it "adds peer to #peers" do
      square.add_peers( peer.id.to_sym => peer )
      expect( square.peers ).to include( peer )
    end

    it "only adds peer once" do
      square.add_peers( peer.id.to_sym => peer )
      square.add_peers( peer.id.to_sym => peer )
      expect( square.peers ).to match_array( [peer] )
    end
  end

  describe "#value=" do
    it "doesn't assign a zero" do
      square.value = 0
      expect( square.value ).to eq(5)
    end

    it "assigns a new value" do
      square.value = 3
      expect( square.value ).to eq(3)
    end

    context "Given an impossible value" do
      it "calls Board::bad_move" do
        square.value = 10
        expect( board ).to have_received( :bad_move ).with( square: square, value: 10, possible_values: (1..9).to_a )
      end
    end

    context "Given a possible value" do
      it "doesn't call Board::bad_move" do
        expect( board ).not_to receive( :bad_move )
        square.add_peers( peer.id.to_sym => peer )
      end
    end
  end

  describe "update" do
    context "given a peer as an argument" do
      # we Indirectly test this by intentionally tripping
      # the board::bad_move call by setting the squares value
      # to that of a peer after calling square::update with said
      # peer.
      it "should update possible values" do
        expect( board ).to receive( :bad_move )
        square.add_peers( peer.id.to_sym => peer )
        square.update peer: peer
        square.value = peer.value
      end
    end
  end

  describe "#update_peers" do
    it "calls update on peers" do
      square.add_peers( peer.id.to_sym => peer )
      square.value = 4
      expect( peer ).to have_received( :update ).with( peer: square )
    end
  end
end
