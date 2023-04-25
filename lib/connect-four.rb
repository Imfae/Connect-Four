require_relative 'pegs'
require_relative 'board'
require_relative 'computer-player'

class Game
  include Alogrithm
  include Pegs

  def initialize(board = Board.new)
    @board = board
    @win_conditions = { 'red' => Array.new(4, red_peg), 'blue' => Array.new(4, blue_peg) }
  end

  def gameplay
    intro_message
    opponent_message
    choose_opponent
    @board.display_board
    player_switch
    if @board.draw?(@board.game_board)
      draw_message
    else
      victory_message(@last_player)
    end
  end

  def choose_opponent
    loop do
      @opponent = gets.chomp.to_i
      break if @opponent.between?(1, 2)

      puts 'Input not supported. Please enter 1 or 2.'
    end
  end

  def receive_input(player)
    return @input = minimax(@board.game_board, true)[1] if player == 'blue' && @opponent == 2

    loop do
      @input = gets.chomp.to_i
      if @input.between?(1, 7)
        if possible_moves(@board.game_board).include?(@input)
          break
        else
          puts 'The column filled. Please choose another.'
        end
      else
        puts 'The input is out of bounds. Please enter a number between 1 and 7.'
      end
    end
  end

  def player_switch
    loop do
      %w[red blue].each do |i|
        puts "\nPlayer #{i}'s turn:"
        receive_input(i)
        @board.update_board(@board.game_board, i, @input)
        @board.display_board
        return @last_player = i if game_end(@board.game_board)
      end
    end
  end

  def possible_moves(board)
    ary = []
    7.times { |i| ary << i + 1 if board[0].split[i] == empty_peg }
    ary
  end

  def game_end(board)
    @board.win?(@win_conditions['blue'], 4, board) || @board.win?(@win_conditions['red'], 4, board) || @board.draw?(board)
  end

  private

  def intro_message
    puts 'Welcome to the game of Connect 4!'
    puts 'Enter the number corresponding to a column to drop a piece.'
    puts 'The first player to get four pieces in a row, a column, or a diagonal wins!'
    puts
  end

  def opponent_message
    puts 'Press 1 for a human v. human game and 2 for a human v. computer game.'
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
