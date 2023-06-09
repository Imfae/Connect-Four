require_relative '../lib/board'

describe Board do
  include_context :colors

  subject(:board) { described_class.new }
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

    context 'when target column is empty' do

      let(:previous_board) { Array.new(6, Array.new(7, empty_peg).join(' ')) }
      
      context 'when Red and 1 are passed' do
      
        it 'returns updated board' do
          new_board = [
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{red_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}"
          ]

          update = board.update_board(previous_board, 'red', 1)
          expect(update).to eql(new_board)
        end
      end

      context 'when Blue and 5 are passed' do
      
        it 'returns updated board' do
          new_board = [
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg}"
          ]

          update = board.update_board(previous_board, 'blue', 5)
          expect(update).to eql(new_board)
        end
      end
    end

    context 'when target column is occupied but not full' do
      
      context 'when Red and 1 are passed' do
        
        it 'returns updated board' do
          previous_board = [
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{red_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{blue_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}"
          ]

          new_board = [
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{red_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{red_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{blue_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}"
          ]

          update = board.update_board(previous_board, 'red', 1)
          expect(update).to eql(new_board)
        end
      end

      context 'when Blue and 7 are passed' do

        it 'returns updated board' do
          previous_board = [
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{red_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{red_peg}"
          ]

          new_board = [
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{red_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{red_peg}"
          ]

          update = board.update_board(previous_board, 'blue', 7)
          expect(update).to eql(new_board)
        end
      end

      context 'when Blue and 4 are passed' do
        
        it 'returns updated board' do
          previous_board = [
            "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg} #{empty_peg}"
          ]

          new_board = [
            "#{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
            "#{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg} #{empty_peg}"
          ]

          update = board.update_board(previous_board, 'blue', 4)
          expect(update).to eql(new_board)
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

    context 'when four consecutive red pegs are in a backward diagonal' do
      
      before do
        preset_board = [
          "#{blue_peg} #{blue_peg} #{blue_peg} #{red_peg} #{blue_peg} #{empty_peg} #{empty_peg}",
          "#{blue_peg} #{blue_peg} #{red_peg} #{red_peg} #{red_peg} #{empty_peg} #{empty_peg}",
          "#{blue_peg} #{blue_peg} #{red_peg} #{blue_peg} #{red_peg} #{red_peg} #{empty_peg}",
          "#{red_peg} #{red_peg} #{blue_peg} #{red_peg} #{red_peg} #{red_peg} #{empty_peg}",
          "#{blue_peg} #{red_peg} #{red_peg} #{red_peg} #{blue_peg} #{blue_peg} #{empty_peg}",
          "#{blue_peg} #{blue_peg} #{red_peg} #{red_peg} #{red_peg} #{blue_peg} #{blue_peg}"
        ]

        board.instance_variable_set(:@game_board, preset_board)
      end

      it 'returns true for red' do
        expect(board).to be_diagonal_win(red_win)
      end
    end

    context 'when four consecutive blue pegs are in a forward diagonal' do
      
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

