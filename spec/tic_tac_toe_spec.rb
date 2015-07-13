require_relative '../lib/tic_tac_toe'

describe TicTacToe do
  it "should be a module" do
    expect(TicTacToe).to be_a(Module)
  end
end
