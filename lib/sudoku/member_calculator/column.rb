module Sudoku
module MemberCalculator
class Column < Base

  def calc_members( container )
     (1..9).to_a.map! do |n|
      n = (9 * (n - 1)) + container.id
    end
  end

  def set_square_container( square )
    if calc_members( square ).include? square.id
      square.column = @container
    end
  end
end
end
end
