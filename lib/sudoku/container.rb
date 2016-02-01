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

  def update_peers( args={} )
    raise NotImplementedError, "Containers must implement update_peers"
  end
end
end
