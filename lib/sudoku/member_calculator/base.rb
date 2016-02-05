module Sudoku
module MemberCalculator
class Base

  def calc_members
    raise NotImplementedError, "Containers must implement calc_members"
  end
end
end
end
