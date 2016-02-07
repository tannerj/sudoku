module Sudoku
module MemberCalculator
class Base

  def calc_members
    raise NotImplementedError, "Containers must implement calc_members"
  end

  def set_square_container( square )
    raise NotImplementedError, "MemberCalculators must implement set_square_container"
  end
end
end
end
