require 'tic_tac_toe'

module TicTacToe
  class TicTacToeService
    attr_reader :inviter

    def initialize player
      @inviter = player
    end

    def play
      TicTacToe::GameBoard.new do |game_board|
        game_board.players[0].name = inviter
      end
    end
  end
end
