require_relative '../../lib/tic_tac_toe/game_board'

module TicTacToe
  describe GameBoard do
    it "should be a class" do
      expect(GameBoard).to be_a(Class)
    end
  end
end
