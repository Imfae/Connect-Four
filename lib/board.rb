
class Board
  def initialize
    @empty_peg = "\u25ef"
    @red_peg = "\e[91m\u2b24\e[0m"
    @blue_peg = "\e[94m\u2b24\e[0m"
    @win_condition = [Array.new(4, @red_peg), Array.new(4, @blue_peg)]
    @game_board = Array.new(6, Array.new(7, @empty_peg).join(' '))
  end

  def display_board
    puts @game_board.join("\n")
  end

  def update_board(player, column)
    row_number = 5
    while row_number >= 0
      target_peg = @game_board[row_number].split[column - 1]
      break if target_peg == @empty_peg

      row_number -= 1
    end
    @game_board[row_number] = @game_board[row_number].split
    @game_board[row_number][column - 1] = (player == 'red' ? @red_peg : @blue_peg)
    @game_board[row_number] = @game_board[row_number].join(' ')
    display_board
  end

  def win?
    [horizontal_win?, vertical_win?, diagonal_win?].include?(true)
  end

  def horizontal_win?
    @game_board.any? do |row|
      row.split.each_cons(4).any? do |i|
        @win_condition.include?(i)
      end
    end
  end

  def vertical_win?(board = @game_board)
    (0..6).any? do |num|
      column_stored = []
      board.each do |row|
        column_stored << row.split[num]
      end
      column_stored.each_cons(4).any? do |i|
        @win_condition.include?(i)
      end
    end
  end

  def diagonal_win?
    n = 0
    modified_board = Array.new(2){ Array.new }
    @game_board.each do |r|
      decrease_pad = (5 - n) * 2 + r.length
      increase_pad = n * 2 + r.length
      modified_board[0] << r.rjust(decrease_pad, 'x ')
      modified_board[1] << r.rjust(increase_pad, 'x ')
      n += 1
    end
    modified_board.any? { |i| vertical_win?(i) }
  end

  def draw?
    @game_board.all? do |row|
      row.split.all? do |element|
        element != @empty_peg
      end
    end
  end
end
