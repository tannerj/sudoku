module Sudoku
  class Square
    attr_reader :id, :value, :peers
  
    def initialize( args={} )
      @id = args.fetch(:id)
      @value = args.fetch(:value, 0)
      @possible_values = [1, 2, 3, 4, 5, 6, 7, 8, 9]
      @peers = []
      @board = args.fetch(:board, nil)
    end
  
    def add_peers( peer_hash )
      peer_hash.each do |index, peer|
        next if peer.id == @id
        if !@peers.include? peer
          @peers << peer
        end
      end
    end

    def value= (value)
      value = value.to_i
      return if value == 0
      @value = value
      if !@possible_values.include? value
        @board.bad_move square: self, value: value, possible_values: @possible_values
      else
        update_peers
      end
    end

    def update( args={} )
      altered_peer = args.fetch(:peer)
      if @peers.include? altered_peer
        @possible_values.delete altered_peer.value
      end
    end

    private

    def update_peers
      @peers.each do | peer |
        peer.update peer: self
      end
    end
  end
end
