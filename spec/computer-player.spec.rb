require_relative '../lib/computer-player'
require_relative '../lib/connect-four'

describe Algorithm do
  include_context :colors

  let(:dummy_class) { Game.new { extend Alogrithm } }

  describe '#nonleaf_evaluation' do
    
    context 'when board has 1 pair of horizontal red pegs' do
      
      it 'returns -1' do
        new_board = [
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{red_peg} #{blue_peg}"
        ]
        expect(dummy_class.nonleaf_evaluation(new_board)).to eql(-1)
      end
    end

    context 'when board has a triple of horizontal blue pegs' do
      
      it 'returns 3' do
        new_board = [
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{blue_peg} #{blue_peg} #{blue_peg}"
        ]
        expect(dummy_class.nonleaf_evaluation(new_board)).to eql(3)
      end
    end

    context 'when board has a pair of vertical blue pegs' do
      
      it 'returns 1' do
        new_board = [
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{blue_peg} #{red_peg} #{empty_peg}"
        ]
        expect(dummy_class.nonleaf_evaluation(new_board)).to eql(1)
      end
    end

    context 'when board has a pair of diagonal red pegs' do
      
      it 'returns -1' do
        new_board = [
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg} #{empty_peg}"
        ]
        expect(dummy_class.nonleaf_evaluation(new_board)).to eql(-1)
      end
    end

    context 'when board has a pair of vertical red pegs and a triple of horizontal red pegs' do
      
      it 'returns -6' do
        new_board = [
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{red_peg} #{red_peg} #{red_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg} #{empty_peg}"
        ]
        expect(dummy_class.nonleaf_evaluation(new_board)).to eql(-6)
      end
    end

    context 'when board has 5 pairs of red pegs, 3 pairs of blue pegs, and 1 triple of blue pegs' do
      
      it 'returns 1' do
        new_board = [
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{blue_peg} #{blue_peg} #{red_peg} #{red_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{red_peg} #{blue_peg} #{red_peg} #{blue_peg} #{blue_peg} #{blue_peg}"
        ]
        expect(dummy_class.nonleaf_evaluation(new_board)).to eql(1)
      end
    end
  end

  describe '#minimax' do

    context 'when blue will win if 4 is the next move' do

      it 'returns array [100, 4]' do
        current_state = [
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{red_peg} #{red_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{blue_peg} #{blue_peg}"
        ]

        expect(dummy_class.minimax(current_state, true)).to eql([100, 4])
      end
    end

    context 'when red has a three-pieces threat in column 5' do
      
      it 'returns 5 as next move' do
        current_state = [
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{red_peg} #{blue_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{blue_peg} #{red_peg}"
        ]

        expect(dummy_class.minimax(current_state, true)[1]).to eql(5)
      end
    end

    context 'when blue will lose within 4 steps' do
      
      it 'returns score of -100' do
        current_state = [
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{red_peg} #{empty_peg} #{empty_peg} #{blue_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{blue_peg} #{empty_peg} #{red_peg} #{red_peg} #{empty_peg} #{empty_peg} #{empty_peg}",
          "#{blue_peg} #{empty_peg} #{red_peg} #{red_peg} #{blue_peg} #{empty_peg} #{empty_peg}",
          "#{blue_peg} #{blue_peg} #{red_peg} #{red_peg} #{red_peg} #{blue_peg} #{empty_peg}"
        ]
        
        expect(dummy_class.minimax(current_state, true)[0]).to eql(-100)
      end
    end
  end
end
