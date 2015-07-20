require_relative '../../lib/tic_tac_toe/player'

module TicTacToe
  describe Player do
    let(:player) {Player.new('x')}

    it "should be a class" do
      expect(Player).to be_a(Class)
    end

    context :player_props do
      it "should maintain instance variable @name" do
        expect(player).to respond_to(:name)
        expect(player.name).to eq(nil)

        expect(Player.new("Mhmoud", 'x').name).to eq("Mhmoud")
      end

      it "should maintain instance variable @symbol" do
        expect(player).to respond_to(:tic_symbol)
      end

      it "should have only two possible symbols (x|o)" do
        expect {player.tic_symbol = 'z'}.to raise_error(/Not supported/)
      end

    end
  end
end
