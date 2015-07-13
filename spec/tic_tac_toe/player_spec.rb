require_relative '../../lib/tic_tac_toe/player'

module TicTacToe
  describe Player do
    it "should be a class" do
      expect(Player).to be_a(Class)
    end
  end
end
