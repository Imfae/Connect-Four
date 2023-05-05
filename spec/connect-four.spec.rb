require_relative '../lib/connect-four'

describe Game do
  include_context :colors

  let(:board) { double('board') }
  subject(:game) { described_class.new(board) }

  describe '#choose_opponent' do
    
    context 'when 1 is given as input' do
      
      before do
        allow(game).to receive(:gets).and_return('1')
        allow(game).to receive(:puts)
      end

      it 'does not output error' do
        error = 'Input not supported. Please enter 1 or 2.'
        expect(game).not_to receive(:puts).with(error)

        game.choose_opponent
      end
    end

    context 'when 2 is given as input' do
      
      before do
        allow(game).to receive(:gets).and_return('2')
        allow(game).to receive(:puts)
      end

      it 'does not output error' do
        error = 'Input not supported. Please enter 1 or 2.'
        expect(game).not_to receive(:puts).with(error)

        game.choose_opponent
      end
    end

    context 'when i, 3, then 2 are given as inputs' do

      before do
        allow(game).to receive(:gets).and_return('i', '3', '2')
        allow(game).to receive(:puts)
      end
      
      it 'output input not supported error twice' do
        error = 'Input not supported. Please enter 1 or 2.'
        expect(game).to receive(:puts).with(error).twice

        game.choose_opponent
      end
    end
  end
  
  describe '#receive_input' do

    context 'when no column on the board is filled' do
      
      before do
        empty_board = [
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}"
        ]
        allow(board).to receive(:game_board).and_return(empty_board)
      end

      context 'when red inputs 7' do

        before do
          allow(game).to receive(:gets).and_return('7')
          allow(game).to receive(:puts)
        end

        it 'does not output error' do
          error = 'The input is out of bounds. Please enter a number between 1 and 7.'
          expect(game).not_to receive(:puts).with(error)

          game.receive_input('red')
        end
      end

      context 'when blue inputs 9, then 3' do

        before do
          allow(game).to receive(:gets).and_return('9', '3')
          allow(game).to receive(:puts)
        end

        it 'outputs out of bounds error once' do
          error = 'The input is out of bounds. Please enter a number between 1 and 7.'
          expect(game).to receive(:puts).with(error).once

          game.receive_input('blue')
        end
      end

      context 'when red inputs a string, 0, then 3' do

        before do
          allow(game).to receive(:gets).and_return('number', '0', '3')
          allow(game).to receive(:puts)
        end

        it 'outputs out of bounds error twice' do
          error = 'The input is out of bounds. Please enter a number between 1 and 7.'
          expect(game).to receive(:puts).with(error).twice

          game.receive_input('red')
        end
      end
    end

    context 'when column 5 is filled' do
      
      before do
        played_board = [
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg}"
        ]
        allow(board).to receive(:game_board).and_return(played_board)
      end

      context 'when blue inputs 5, then 3' do

        before do
          allow(game).to receive(:gets).and_return('5', '3')
          allow(game).to receive(:puts)
        end

        it 'outputs column is full error once' do
          error = 'The column filled. Please choose another.'
          expect(game).to receive(:puts).with(error).once

          game.receive_input('blue')
        end
      end
    end
  end

  describe '#player_switch' do

    before do
      allow(game).to receive(:puts)
      allow(board).to receive(:update_board)
      allow(board).to receive(:display_board)
    end

    context 'when red wins after inputting 2' do

      before do
        played_board = [
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{red_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{red_peg} #{empty_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{red_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg}"
        ]
        allow(game).to receive(:gets).and_return('2')
        allow(board).to receive(:game_board).and_return(played_board)
        allow(board).to receive(:win?).and_return(true)
      end
      
      it "returns @last_player as 'red'" do
        expect(game.player_switch).to eql('red')
      end
    end

    context 'when blue wins after red inputs 3 and blue inputs 3' do

      before do
        played_board = [
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{red_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{red_peg} #{empty_peg} #{red_peg} #{blue_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{blue_peg} #{empty_peg} #{blue_peg} #{red_peg} #{empty_peg} #{empty_peg}",
          "#{blue_peg} #{blue_peg} #{red_peg} #{red_peg} #{blue_peg} #{empty_peg} #{empty_peg}"
        ]
        allow(board).to receive(:game_board).and_return(played_board)
        allow(game).to receive(:gets).and_return('3', '3')
        allow(game).to receive(:game_end).and_return(false, true)
      end

      it "returns @last_player as 'blue'" do
        expect(game.player_switch).to eql('blue')
      end
    end
  end

  describe '#possible_moves' do
    
    context 'when no column is filled' do
      
      it 'returns [1, 2, 3, 4, 5, 6, 7]' do
        new_board = [
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{blue_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{red_peg} #{blue_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg} #{empty_peg}"
        ]
        expect(game.possible_moves(new_board)).to eql([1, 2, 3, 4, 5, 6, 7])
      end
    end

    context 'when column 4 is filled' do
      
      it 'returns [1, 2, 3, 5, 6, 7]' do
        new_board = [
          "#{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg} #{empty_peg}"
        ]
        expect(game.possible_moves(new_board)).to eql([1, 2, 3, 5, 6, 7])
      end
    end

    context 'when columns 1, 3, 6, 7 are filled' do

      it 'returns [2, 4, 5]' do
        new_board = [
          "#{red_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{blue_peg}",
          "#{blue_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{red_peg} #{red_peg}",
          "#{red_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{blue_peg}",
          "#{blue_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{red_peg} #{red_peg}",
          "#{red_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{blue_peg}",
          "#{blue_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{red_peg} #{red_peg}"
        ]
        expect(game.possible_moves(new_board)).to eql([2, 4, 5])
      end
    end
  end
end
