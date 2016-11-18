module Sudoku
  class Unit
    attr_reader :id, :members
  
    def initialize( args={} )
      @id = args.fetch(:id)
      @members = {}
    end
  
    def add_member(member)
      if !@members.include? member 
        @members[member.id.to_sym] = member
        return true
      end
      false
    end
  end
  
  class Row < Unit
  end
  
  class Column < Unit
  end
  
  class Box < Unit
  end
end
