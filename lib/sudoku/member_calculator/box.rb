module Sudoku
module MemberCalculator
class Box < Base
  
  def calc_members( container )
    (1..9).to_a.map! do |n|
      #  The second and third box row's members need to
      #  have 18 and 32, respectively, added to their
      #  members. We add a box multiplier calculation
      #  to add this value members when needed.
      box_multiplier = ((container.id / 3.0).ceil - 1) * 18
      first_member = box_multiplier + (3 * (container.id - 1)) + 1
      row = ((n / 3.0).ceil - 1)#zero indexed
      n = (row * 9) + (first_member + (n - 1) - (3 * row))
    end
  end
end
end
end
