require_relative '../lib/connect-four'

describe Game do

  let(:board) { double('board') }
  subject(:game) { described_class.new(board) }
  
  describe '#prompt_input' do

    context 'when input is between 1 and 7' do

      before do
        allow(game).to receive(:gets).and_return('7')
        allow(game).to receive(:puts)
      end

      it 'does not output error' do
        expect(game).not_to receive(:puts)

        game.prompt_input
      end
    end

    context 'when input is a number not between 1 and 7, then 3' do

      before do
        allow(game).to receive(:gets).and_return('9', '3')
        allow(game).to receive(:puts)
      end

      it 'outputs out of bounds error once' do
        error = 'The input is out of bounds. Please enter a number between 1 and 7.'
        expect(game).to receive(:puts).with(error).once

        game.prompt_input
      end
    end

    context 'when input is a string, a number out of bounds, then 3' do

      before do
        allow(game).to receive(:gets).and_return('number', '0', '3')
        allow(game).to receive(:puts)
      end

      it 'outputs out of bounds error once' do
        error = 'The input is out of bounds. Please enter a number between 1 and 7.'
        expect(game).to receive(:puts).with(error).twice

        game.prompt_input
      end
    end

    context 'when input is an integer that has been entered 6 times, then is 3' do

      before do
        new_record = {
          1 => 0,
          2 => 0,
          3 => 0,
          4 => 0,
          5 => 6,
          6 => 0,
          7 => 0
        }
        game.instance_variable_set(:@inputs_record, new_record)
        allow(game).to receive(:gets).and_return('5', '3')
        allow(game).to receive(:puts)
      end

      it 'outputs column is full once' do
        error = 'The column filled. Please choose another.'
        expect(game).to receive(:puts).with(error).once

        game.prompt_input
      end
    end
  end

  describe '#player_switch' do

    context 'when game win is one input away' do

      before do
        allow(game).to receive(:puts)
        allow(game).to receive(:gets).and_return('2')
        allow(board).to receive(:update_board)
        allow(board).to receive(:win?).and_return(true)
        allow(board).to receive(:draw?).and_return(false)
      end
      
      it 'increases @inputs_record[input] by one, then returns' do
        input = 2
        expect { game.player_switch }.to change { game.instance_variable_get(:@inputs_record)[input] }.by(1)
      end
    end

    context 'when game win is three inputs away' do

      before do
        allow(game).to receive(:puts)
        allow(game).to receive(:gets).and_return('2', '3', '2')
        allow(board).to receive(:update_board)
        allow(board).to receive(:win?).and_return(false, false, true)
        allow(board).to receive(:draw?).and_return(false, false)
      end
      
      it 'increases @inputs_record[red_input] by two, then returns' do
        red_input = 2
        expect { game.player_switch }.to change { game.instance_variable_get(:@inputs_record)[red_input] }.by(2)
      end
    end

    context 'when game draw is one input away' do

      before do
        allow(game).to receive(:puts)
        allow(game).to receive(:gets).and_return('7')
        allow(board).to receive(:update_board)
        allow(board).to receive(:win?).and_return(false)
        allow(board).to receive(:draw?).and_return(true)
      end
      
      it 'increases @inputs_record[input] by one, then returns' do
        input = 7
        expect { game.player_switch }.to change { game.instance_variable_get(:@inputs_record)[input] }.by(1)
      end
    end
  end

  describe '#gameplay' do
    
    
  end
end
