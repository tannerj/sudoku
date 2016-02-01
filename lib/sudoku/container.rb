module Sudoku
module Container

  def calc_members
    raise NotImplementedError, "Containers must implement calc_members"
  end

  def get_members
    raise NotImplementedError, "Containers must implement get_members"
  end

  def add_member( args={} )
    raise NotImplementedError, "Containers must implement add_member"
  end
end
end
