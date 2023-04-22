module Alogrithm
  def minimax(current_state, is_maximizing, cache = {}, depth = 4, alpha = -50, beta = 50)
    if game_end(current_state) || depth == 0
      return [evaluate_game(current_state)]
    else
      score = is_maximizing ? -50 : 50
      next_move = 0
      possible_moves(current_state).each do |i|
        temp_board = current_state.dup
        if is_maximizing
          test_board = @board.update_board(temp_board, 'blue', i)
        else
          test_board = @board.update_board(temp_board, 'red', i)
        end

# puts test_board
# puts

        new_score = cache[test_board] ||= minimax(test_board, !is_maximizing, cache, depth - 1, alpha, beta)[0]
# puts new_score
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
