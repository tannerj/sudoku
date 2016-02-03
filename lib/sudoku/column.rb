module Sudoku
class Column
  include MemberCalculator

  def calc_members( square_id )
     (1..9).to_a.map! do |n|
      n = (9 * (n - 1)) + square_id
    end
  end
end
end
