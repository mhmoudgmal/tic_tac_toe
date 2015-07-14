require_relative '../../lib/tic_tac_toe/game_board'

module TicTacToe
  describe GameBoard do
    let(:game) {GameBoard.new}

    it "should be a class" do
      expect(GameBoard).to be_a(Class)
    end

    context :game_board_props do

      it "should have a board structure, 9 cell boolean based to indicate if it's blank or not" do
        expect(game).to respond_to(:board)
        expect(game.board).to eq(Array.new(9, false))
      end

      it "should hold an array of (two) players Player instances" do
        expect(game).to respond_to(:players)
        expect(game.players).to be_a(Array)
        expect(game.players.length).to eq(2)
        expect(game.players.all? {|p| p.kind_of?(Player)}).to be_truthy
      end

      it "should maintain GameStatus module stuff" do
        expect(game).to respond_to(:status)
        expect(game).to respond_to(:win?)
        expect(game).to respond_to(:finished?)
      end

    end

    context :board_behaviour do
      it "should react to the changes on board" do
        expect(game.board).to respond_to(:[])

        expect {game.board[0] = 'x'}.to change {game.board[0] }.from(false).to('x')
        expect {game.board[1] = 'o'}.to change {game.board[1] }.from(false).to('o')
      end

      it "should not update the already updated cell/position" do
        expect {
          game.update_board(game.players.first, 1)
        }.to change { game.board[0] }.from(false).to(game.players.first.tic_symbol)

        expect {game.update_board(game.players.first, 1)}.to raise_error /Not blank/
      end

      it "should raise finished when the board is filled" do
        (1..8).to_a.each do |position|
          game.update_board game.current_player, position
        end

        expect(game.update_board(game.current_player, 9)).to eq('BLOCK, play again')
      end

      it "should not accept any further plays after 9 plays" do

      end
    end
  end
end
