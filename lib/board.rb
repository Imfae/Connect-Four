
class Board
  def initialize
    @empty_peg = "\u25ef"
    @red_peg = "\e[91m\u2b24\e[0m"
    @blue_peg = "\e[94m\u2b24\e[0m"
    @game_board = Array.new(6, Array.new(7, @empty_peg).join(' '))
  end

  def display_board
    puts '1 2 3 4 5 6 7'
    puts @game_board.join("\n")
  end

  def update_board(board, player, row, column)
    board[5 - row] = board[5 - row].split
    board[5 - row][column - 1] = (player == 'red' ? @red_peg : @blue_peg)
    board[5 - row] = board[5 - row].join(' ')
    board
  end

  def win?(color_win)
    [horizontal_win?(color_win), vertical_win?(color_win), diagonal_win?(color_win)].include?(true)
  end

  def horizontal_win?(color_win)
    @game_board.any? do |row|
      row.split.each_cons(4).any? do |i|
        color_win.eql?(i)
      end
    end
  end

  def vertical_win?(color_win, board = @game_board)
    (0..6).any? do |num|
      column_stored = []
      board.each do |row|
        column_stored << row.split[num]
      end
      column_stored.each_cons(4).any? do |i|
        color_win.eql?(i)
      end
    end
  end

  def diagonal_win?(color_win)
    n = 0
    modified_board = Array.new(2){ Array.new }
    @game_board.each do |r|
      decrease_pad = (5 - n) * 2 + r.length
      increase_pad = n * 2 + r.length
      modified_board[0] << r.rjust(decrease_pad, 'x ')
      modified_board[1] << r.rjust(increase_pad, 'x ')
      n += 1
    end
    modified_board.any? { |i| vertical_win?(color_win, i) }
  end

  def draw?
    @game_board.all? do |row|
      row.split.all? do |element|
        element != @empty_peg
      end
    end
  end
end
