require_relative 'board'
require_relative 'computer-player'

class Game
  include Alogrithm
  def initialize(board = Board.new)
    @board = board
    @empty_peg = "\u25ef"
    @red_peg = "\e[91m\u2b24\e[0m"
    @blue_peg = "\e[94m\u2b24\e[0m"
    @win_conditions = { 'red' => Array.new(4, @red_peg), 'blue' => Array.new(4, @blue_peg) }
  end

  def gameplay
    intro_message
    @board.display_board
    victory_message(player_switch)
  end

  def prompt_input(player)
    return @input = minimax(@board.game_board, true)[1] if player == 'blue'

    loop do
      @input = gets.chomp.to_i
      if @input.between?(1, 7)
        puts 'The column filled. Please choose another.' unless possible_moves(@board.game_board).include?(@input)
        break
      end
      puts 'The input is out of bounds. Please enter a number between 1 and 7.' unless @input.between?(1, 7)
    end
  end

  def player_switch
    loop do
      %w[red blue].each do |i|
        prompt_input(i)
        update_board(@board.game_board, i, @input)
        @board.display_board
        return i if @board.win?(@win_conditions[i], 4) || @board.draw?
      end
    end
  end

  def possible_moves(board)
    ary = []
    7.times { |i| ary << i + 1 if board[0].split[i] == @empty_peg }
    ary
  end

  def game_end(board)
    @board.win?(@win_conditions['blue'], 4, board) || @board.win?(@win_conditions['red'], 4, board) || @board.draw?(board)
  end

  def evaluate_game(board)
    if @board.win?(@win_conditions['blue'], 4, board)
      42
    elsif @board.win?(@win_conditions['red'], 4, board)
      -42
    elsif @board.draw?(board)
      0
    else
      nonleaf_evaluation(board)
    end
  end

  def nonleaf_evaluation(board)
    score = 0
    two_red = Array.new(2, @red_peg)
    three_red = Array.new(3, @red_peg)
    two_blue = Array.new(2, @blue_peg)
    three_blue = Array.new(3, @blue_peg)
    if @board.win?(two_red, 2, board)
      score += 1
    elsif @board.win?(three_red, 3, board)
      score += 3
    elsif @board.win?(two_blue, 2, board)
      score -= 1
    elsif @board.win?(three_blue, 3, board)
      score -= 3
    end
    score
  end

  private

  def intro_message
    puts 'Welcome to the game of Connect 4!'
    puts 'Enter the number corresponding to a column to drop a piece.'
    puts 'The first player to get four pieces in a row, a column, or a diagonal wins!'
    puts
  end

  def victory_message(color)
    puts "\nPlayer #{color.capitalize} wins this round!"
  end

  def draw_message
    puts "\nThe game is a draw!"
  end
end

game = Game.new
game.gameplay
