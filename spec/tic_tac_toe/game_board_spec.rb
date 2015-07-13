require_relative '../../lib/tic_tac_toe/game_board'

module TicTacToe
  describe GameBoard do
    it "should be a class" do
      expect(GameBoard).to be_a(Class)
    end

    context :game_board_props do
      let(:game_board) {GameBoard.new}

      xit "should have a board structure, 9 cell char-based" do
      end

      xit "should hold an array of (two) players Player instances" do
      end

      xit "should maintain an instance of GameStatus" do
      end

    end
  end
end
