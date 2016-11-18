module Sudoku
  class Square
    attr_reader :id, :peers
  
    def initialize( args={} )
      @id = args.fetch(:id)
      @value = args.fetch(:value, [1,2,3,4,5,6,7,8,9])
      @peers = []
      @board = args.fetch(:board, nil)
      @value_set = false
      @incorrect_value = nil
    end
  
    def add_peers( peer_hash )
      peer_hash.each do |index, peer|
        if !@peers.include? peer
          @peers << peer
        end
      end
    end

    def value
      return @incorrect_value if @incorrect_value # if the player made a mistake, show the mistake not the correct value
      if @value.length == 1 && @value_set
        return @value.first
      else
        return 0
      end
    end

    def value= (value)      
      if !@value.include? value
        @incorrect_value = value
        @board.bad_move square: self, value: value
      else
        @value = [value]
      end
      @value_set = true
    end
  end
end
