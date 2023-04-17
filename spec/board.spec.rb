require_relative '../lib/board'

describe Board do

  subject(:board) { described_class.new }
  let(:empty_peg) { "\u25ef" }
  let(:red_peg) { "\e[91m\u2b24\e[0m" }
  let(:blue_peg) { "\e[94m\u2b24\e[0m" }
  let(:red_win) { Array.new(4, red_peg) }
  let(:blue_win) { Array.new(4, blue_peg) }

  describe 'new board' do

    it 'displays new board' do
      new_board = <<~HEREDOC.chomp
        #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}
        #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}
        #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}
        #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}
        #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}
        #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}
      HEREDOC

      expect(board).to receive(:puts).with(new_board)
      expect(board).to receive(:puts).with('1 2 3 4 5 6 7')
      board.display_board
    end
  end
  
  describe '#update_board' do

    before { expect(board).to receive(:puts).with('1 2 3 4 5 6 7') }

    context 'when target column is empty' do
      
      context 'when Red and 1 are passed' do
      
        it 'returns updated board' do
          new_board = <<~HEREDOC.chomp
            #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}
            #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}
            #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}
            #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}
            #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}
            #{red_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}
          HEREDOC

          expect(board).to receive(:puts).with(new_board)
          
          board.update_board('red', 0, 1)
        end
      end

      context 'when Blue and 5 are passed' do
      
        it 'returns updated board' do
          new_board = <<~HEREDOCS.chomp
            #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}
            #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}
            #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}
            #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}
            #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}
            #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg}
          HEREDOCS

          expect(board).to receive(:puts).with(new_board)

          board.update_board('blue', 0, 5)
        end
      end
    end

    context 'when target column is occupied but not full' do
      
      context 'when Red and 1 are passed' do

        before do
          preset_board = [
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{red_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{blue_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}"
          ]

          board.instance_variable_set(:@game_board, preset_board)
        end
        
        it 'returns updated board' do
          new_board = <<~HEREDOCS.chomp
            #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}
            #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}
            #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}
            #{red_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}
            #{red_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}
            #{blue_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}
          HEREDOCS

          expect(board).to receive(:puts).with(new_board)

          board.update_board('red', 2, 1)
        end
      end

      context 'when Blue and 7 are passed' do

        before do
          preset_board = [
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{red_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{red_peg}"
          ]

          board.instance_variable_set(:@game_board, preset_board)
        end
        
        it 'returns updated board' do
          new_board = <<~HEREDOCS.chomp
            #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}
            #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}
            #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg}
            #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{red_peg}
            #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg}
            #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{red_peg}
          HEREDOCS

          expect(board).to receive(:puts).with(new_board)

          board.update_board('blue', 3, 7)
        end
      end

      context 'when Blue and 4 are passed' do

        before do
          preset_board = [
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg} #{empty_peg}"
          ]

          board.instance_variable_set(:@game_board, preset_board)
        end
        
        it 'returns updated board' do
          new_board = <<~HEREDOCS.chomp
            #{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{empty_peg}
            #{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{empty_peg}
            #{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{empty_peg}
            #{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg} #{empty_peg}
            #{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{empty_peg}
            #{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg} #{empty_peg}
          HEREDOCS

          expect(board).to receive(:puts).with(new_board)

          board.update_board('blue', 5, 4)
        end
      end
    end
  end

  describe '#horizontal_win?' do

    context 'when four consecutive red pegs are in a row' do

      before do
        preset_board = [
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{red_peg} #{red_peg} #{red_peg} #{red_peg} #{empty_peg} #{empty_peg}"
        ]

        board.instance_variable_set(:@game_board, preset_board)
      end

      it 'returns true for red' do
        expect(board).to be_horizontal_win(red_win)
      end
    end

    context 'when four consecutive blue pegs are not in a row' do

      before do
        preset_board = [
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{red_peg} #{blue_peg} #{blue_peg} #{blue_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{blue_peg} #{red_peg} #{red_peg} #{red_peg} #{empty_peg} #{empty_peg}"
        ]

        board.instance_variable_set(:@game_board, preset_board)
      end

      it 'returns false for blue' do
        expect(board).not_to be_horizontal_win(blue_win)
      end
    end
  end

  describe '#vertical_win?' do

    context 'when four consecutive red pegs are in a column' do
      
      before do
        preset_board = [
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{blue_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{blue_peg} #{blue_peg} #{red_peg} #{empty_peg} #{empty_peg} #{empty_peg}"
        ]

        board.instance_variable_set(:@game_board, preset_board)
      end

      it 'returns true for red' do
        expect(board).to be_vertical_win(red_win)
      end
    end

    context 'when four consecutive blue pegs are not in a column' do
      
      before do
        preset_board = [
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{blue_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{blue_peg} #{blue_peg} #{red_peg} #{empty_peg} #{empty_peg} #{empty_peg}"
        ]

        board.instance_variable_set(:@game_board, preset_board)
      end

      it 'returns false for blue' do
        expect(board).not_to be_vertical_win(blue_win)
      end
    end
  end

  describe '#diagonal_win?' do

    context 'when four consecutive red pegs are in a forward diagonal' do
      
      before do
        preset_board = [
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{blue_peg} #{red_peg} #{blue_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{red_peg} #{blue_peg} #{red_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{red_peg} #{blue_peg} #{blue_peg} #{red_peg} #{empty_peg} #{empty_peg}"
        ]

        board.instance_variable_set(:@game_board, preset_board)
      end

      it 'returns true for red' do
        expect(board).to be_diagonal_win(red_win)
      end
    end

    context 'when four consecutive blue pegs are in a backward diagonal' do
      
      before do
        preset_board = [
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{blue_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{red_peg} #{blue_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{red_peg} #{red_peg} #{red_peg} #{blue_peg} #{empty_peg} #{empty_peg}",
          "#{red_peg} #{red_peg} #{blue_peg} #{red_peg} #{blue_peg} #{empty_peg} #{empty_peg}"
        ]

        board.instance_variable_set(:@game_board, preset_board)
      end

      it 'returns true for blue' do
        expect(board).to be_diagonal_win(blue_win)
      end
    end

    context 'when four consecutive red pegs are not in a diagonal' do
      
      before do
        preset_board = [
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{blue_peg} #{red_peg} #{blue_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{red_peg} #{blue_peg} #{red_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{red_peg} #{blue_peg} #{blue_peg} #{red_peg} #{empty_peg} #{empty_peg}"
        ]

        board.instance_variable_set(:@game_board, preset_board)
      end

      it 'returns false for red' do
        expect(board).not_to be_diagonal_win(red_win)
      end
    end
  end

  describe '#draw?' do

    context 'when draw' do

      before do
        preset_board = [
          "#{red_peg}#{red_peg}#{red_peg}#{red_peg}#{red_peg}#{red_peg}#{red_peg}",
          "#{red_peg}#{red_peg}#{red_peg}#{red_peg}#{red_peg}#{red_peg}#{red_peg}",
          "#{red_peg}#{red_peg}#{red_peg}#{blue_peg}#{red_peg}#{red_peg}#{red_peg}",
          "#{red_peg}#{red_peg}#{red_peg}#{red_peg}#{red_peg}#{red_peg}#{red_peg}",
          "#{red_peg}#{red_peg}#{red_peg}#{blue_peg}#{red_peg}#{red_peg}#{red_peg}",
          "#{red_peg}#{red_peg}#{red_peg}#{red_peg}#{red_peg}#{red_peg}#{red_peg}"
        ]

        board.instance_variable_set(:@game_board, preset_board)
      end

      it 'returns true' do
        expect(board).to be_draw
      end
    end

    context 'when not draw' do
      before do
        preset_board = [
          "#{red_peg} #{empty_peg} #{red_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg}",
          "#{red_peg} #{red_peg} #{red_peg} #{red_peg} #{red_peg} #{red_peg} #{empty_peg}",
          "#{red_peg} #{red_peg} #{red_peg} #{blue_peg} #{red_peg} #{red_peg} #{red_peg}",
          "#{red_peg} #{red_peg} #{red_peg} #{red_peg} #{red_peg} #{red_peg} #{red_peg}",
          "#{red_peg} #{red_peg} #{red_peg} #{blue_peg} #{red_peg} #{red_peg} #{red_peg}",
          "#{red_peg} #{red_peg} #{red_peg} #{red_peg} #{red_peg} #{red_peg} #{red_peg}"
        ]

        board.instance_variable_set(:@game_board, preset_board)
      end

      it 'returns false' do
        expect(board).not_to be_draw
      end
    end
  end
end

