require_relative '../../lib/tic_tac_toe/game_status'

module TicTacToe
  describe GameStatus do
    it "should be a class" do
      expect(GameStatus).to be_a(Module)
    end


    context :game_status_props do

      it "should respond to finished?" do
        expect(GameStatus.method_defined?(:finished?)).to be_truthy
      end

      it "should respond to win?" do
        expect(GameStatus.method_defined?(:win?)).to be_truthy
      end

    end
  end
end
