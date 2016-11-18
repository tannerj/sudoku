require_relative 'sudoku/board'
require_relative 'sudoku/square'
require_relative 'sudoku/units'
require_relative 'sudoku/io'

board = Sudoku::Board.new
puts Sudoku::IO::CLI.render_board board
