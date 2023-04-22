
class Board
  attr_reader :game_board
  def initialize
    @empty_peg = "\u25ef"
    @red_peg = "\e[91m\u2b24\e[0m"
    @blue_peg = "\e[94m\u2b24\e[0m"
    @game_board = Array.new(6) { Array.new(7, @empty_peg).join(' ') }
  end

  def display_board
    puts '1 2 3 4 5 6 7'
    puts @game_board.join("\n")
  end

  def update_board(board, player, column)
    row_number = 5
    while row_number >= 0
      target_peg = board[row_number].split[column - 1]
      break if target_peg == @empty_peg

      row_number -= 1
    end
    board[row_number] = board[row_number].split
    board[row_number][column - 1] = (player == 'red' ? @red_peg : @blue_peg)
    board[row_number] = board[row_number].join(' ')
    board
  end

  def win?(color_win, length = 4, board = @game_board)
    [horizontal_win?(color_win, length, board), vertical_win?(color_win, length, board), diagonal_win?(color_win, length, board)].include?(true)
  end

  def horizontal_win?(color_win, length = 4, board = @game_board)
    board.any? do |row|
      row.split.each_cons(length).any? do |i|
        color_win.eql?(i)
      end
    end
  end

  def vertical_win?(color_win, length = 4, board = @game_board)
    (0..6).any? do |num|
      column_stored = []
      board.each do |row|
        column_stored << row.split[num]
      end
      column_stored.each_cons(length).any? do |i|
        color_win.eql?(i)
      end
    end
  end

  def diagonal_win?(color_win, length = 4, board = @game_board)
    n = 0
    modified_board = Array.new(2){ Array.new }
    board.each do |r|
      decrease_pad = (5 - n) * 2 + r.length
      increase_pad = n * 2 + r.length
      modified_board[0] << r.rjust(decrease_pad, 'x ')
      modified_board[1] << r.rjust(increase_pad, 'x ')
      n += 1
    end
    modified_board.any? { |i| vertical_win?(color_win, length, i) }
  end

  def draw?(board = @game_board)
    board.all? do |row|
      row.split.all? do |element|
        element != @empty_peg
      end
    end
  end
end
