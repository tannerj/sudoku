require_relative 'sudoku/board'
require_relative 'sudoku/square'
require_relative 'sudoku/units'
require_relative 'sudoku/io'

board = Sudoku::Board.new
game = "010020300004005060070000008006900070000100002030048000500006040000800106008000000"
game_array = []

game.each_char do |char|
  game_array << char
end

board.squares.each do |index, square|
  value = game_array.shift
  square.value = value if value != 0
end

board.squares["G7"].value = 8
puts Sudoku::IO::CLI.render_board board: board
