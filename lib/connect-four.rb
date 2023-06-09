require_relative 'pegs'
require_relative 'board'
require_relative 'computer-player'

## Class for the Connect-Four game
class Game
  include Algorithm
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
      if @opponent.between?(1, 2)
        puts "\nOne player's color is \e[91mred\e[0m, and the other's is \e[94mblue\e[0m.\n\e[91mRed\e[0m makes the first move!" if @opponent == 1
        puts "\nNow, your color is \e[91mred\e[0m. And the computer's color is \e[94mblue\e[0m.\nMake the first move!" if @opponent == 2
        puts "\n----------------------------------------------------"
        puts
        break
      end

      puts 'Input not supported. Please enter 1 or 2.'
    end
  end

  def receive_input(player)
    return @input = minimax(@board.game_board, true)[1] if player == 'blue' && @opponent == 2

    loop do
      @input = gets.chomp.to_i
      if @input.between?(1, 7)
        if possible_moves(@board.game_board).include?(@input)
          puts
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
        print "\nPlayer "
        i == 'red' ? print("\e[91mred\e[0m's ") : print("\e[94mblue\e[0m's ")
        print "turn:"
        puts
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
    puts
    puts 'Welcome to the game of Connect 4!'
    puts
    puts 'Enter the number corresponding to a column to drop a colored piece. The first player to get four pieces in a row, a column, or a diagonal wins!'
    puts
  end

  def opponent_message
    puts 'Press (1) for a human v. human game and (2) for a human v. computer game.'
  end

  def victory_message(color)
    puts "\n#{color.capitalize} wins this round!"
  end

  def draw_message
    puts "\nThe game is a draw!"
  end
end

def play_again?
  play_again = $stdin.gets.chomp.downcase
  if play_again.include?('y')
    true
  elsif play_again.include?('n')
    false
  else
    puts "\nPlease enter 'y' or 'n'."
    play_again?
  end
end

## Game loop
loop do
  game = Game.new
  game.gameplay
  puts "\nWould you like to play again? (y/n)"
  play_again? ? redo : break
end

