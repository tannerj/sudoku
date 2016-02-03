module Sudoku
class Column
  include MemberCalculator

  def calc_members( container )
     (1..9).to_a.map! do |n|
      n = (9 * (n - 1)) + container.id
    end
  end
end
end
