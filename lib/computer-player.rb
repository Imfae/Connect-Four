## Methods that make up the computer player's algorithm
module Algorithm
  # Assign a score to the given game board
  def evaluate_game(board)
    if @board.win?(@win_conditions['blue'], 4, board)
      100
    elsif @board.win?(@win_conditions['red'], 4, board)
      -100
    elsif @board.draw?(board)
      0
    else
      nonleaf_evaluation(board)
    end
  end

  # Used for nonleaf board states, the system calculates score according to the numbers of two
  # consecutive pegs and three consecutive pegs for each color on the board.
  def scoring_system(score, str)
    two_red = "#{red_peg} #{red_peg}"
    three_red = "#{red_peg} #{red_peg} #{red_peg}"
    two_blue = "#{blue_peg} #{blue_peg}"
    three_blue = "#{blue_peg} #{blue_peg} #{blue_peg}"

    dup_str = str.dup
    score = score - dup_str.scan(three_red).length * 3 + dup_str.scan(three_blue).length * 3
    dup_str.gsub!(three_red, 'o o o')
    dup_str.gsub!(three_blue, 'o o o')
    score - dup_str.scan(two_red).length + dup_str.scan(two_blue).length
  end

  # Change board's columns to a format usable by scoring_system
  def inspect_vertical(board)
    9.times do |num|
      column_stored = ''
      board.each do |row|
        column_stored.concat(row.split[num], ' ') unless row.split[num].nil?
      end
      yield(column_stored)
    end
  end

  # Evaluate score for nonleaf board states
  def nonleaf_evaluation(board)
    score = 0
    
    # Evaluate all rows
    board.each do |row|
      score = scoring_system(score, row)
    end

    # Evaluate all columns
    inspect_vertical(board) { |column_stored| score = scoring_system(score, column_stored) }

    # Evaluate all diagonals
    n = 0
    modified_boards = Array.new(2){ Array.new }
    board.each do |r|
      decrease_pad = (5 - n) * 2 + r.length
      increase_pad = n * 2 + r.length
      modified_boards[0] << r.rjust(decrease_pad, 'x ')
      modified_boards[1] << r.rjust(increase_pad, 'x ')
      n += 1
    end
    modified_boards.each do |i|
      inspect_vertical(i) { |column_stored| score = scoring_system(score, column_stored) }
    end
    
    # Final score
    score
  end

  def minimax(current_state, is_maximizing, depth = 4, alpha = -100, beta = 100)
    if game_end(current_state) || depth == 0
      return [evaluate_game(current_state)]
    else
      score = is_maximizing ? -100 : 100
      next_move = 0
      possible_moves(current_state).each do |i|
        temp_board = current_state.dup
        if is_maximizing
          test_board = @board.update_board(temp_board, 'blue', i)
        else
          test_board = @board.update_board(temp_board, 'red', i)
        end

        new_score = minimax(test_board, !is_maximizing, depth - 1, alpha, beta)[0]

        if is_maximizing
          if new_score > score
            score = new_score
            next_move = i
          end
        else
          if new_score < score
            score = new_score
            next_move = i
          end
        end

        # Alpha-beta pruning
        if is_maximizing
          if new_score > alpha
            alpha = new_score
          end
        else
          if new_score < beta
            beta = new_score
          end
        end

        if alpha >= beta
          break
        end
      end
      [score, next_move]
    end
  end
end
