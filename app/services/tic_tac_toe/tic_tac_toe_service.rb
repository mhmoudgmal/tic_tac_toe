require 'tic_tac_toe'

module TicTacToe
  class TicTacToeService
    attr_reader :inviter

    def initialize player
      @inviter = player
    end

    def play
      game = TicTacToe::GameBoard.new
      game.players[0].name = inviter
      game
    end
  end
end
