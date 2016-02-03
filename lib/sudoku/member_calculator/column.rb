module Sudoku
module MemberCalculator
class Column < Base

  def calc_members( container )
     (1..9).to_a.map! do |n|
      n = (9 * (n - 1)) + container.id
    end
  end
end
end
end
