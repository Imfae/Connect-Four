require_relative 'board'

class Game
  def initialize(board = Board.new)
    @inputs_record = {
      1 => 0,
      2 => 0,
      3 => 0,
      4 => 0,
      5 => 0,
      6 => 0,
      7 => 0
    }
    @board = board
  end

  def gameplay
    intro_message
    @board.display_board
    victory_message(player_switch)
  end

  def prompt_input
    loop do
      @input = gets.chomp.to_i
      if @input.between?(1, 7)
        puts 'The column filled. Please choose another.' if @inputs_record[@input] == 6
        break
      end
      puts 'The input is out of bounds. Please enter a number between 1 and 7.' unless @input.between?(1, 7)
    end
  end

  def player_switch
    loop do
      %w[red blue].each do |i|
        prompt_input
        @board.update_board(i, @inputs_record[@input], @input)
        @inputs_record[@input] += 1
        return i if @board.win? || @board.draw?
      end
    end
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