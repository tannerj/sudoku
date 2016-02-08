module Sudoku
module MemberCalculator
class Row < Base
  
  def calc_members( container )
    (1..9).to_a.map! do |n|
      (9 * ( container.id - 1)) + n  
    end
  end

  def set_square_container( square )
    if calc_members( square ).include? square.id
      square.row = @container
    end
  end
end
end
end
