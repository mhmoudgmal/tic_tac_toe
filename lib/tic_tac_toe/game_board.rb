require_relative './game_status'
require_relative './player'
require 'byebug'

module TicTacToe
  class GameBoard

    attr_reader :board, :players, :current_player

    include TicTacToe::GameStatus

    def initialize
      @board    = Array.new(9, false)
      @players  = [ Player.new('X'), Player.new('O') ]

      @current_player = @players.first
    end



    ##
    # GameBoard get messaged to update a cell located at +position+ by a +player+.
    #
    # After each update on the board, the board will involve the GameStatus
    # to check whether the +player+ has #win?, or the game has #finshied?
    # without win raised else turn to the next player #change_player.
    def update_board player, position

      raise 'Not blank' if board[position-1] != false

      board[position-1] = player.tic_symbol

      eval(check_game_status)

      change_player
    end



    # Changes player after #update_board
    # Returns::
    #   current_player after has been changed from first player to second player and vice versa
    def change_player
      @current_player =
        players.reject { |p| p.object_id == @current_player.object_id }.first
    end


    def check_game_status
      if win?
        return "return #{@current_player} win!"
      elsif finished?
        return "return 'BLOCK, play again'"
      end

      ''
    end

    # FIXME
    # def alert_player player
    #   player_turn = players.index(player) == 0 ? 'first' : 'second'
    #
    #   puts "#{player_turn} Player (Player-#{current_player.name}) turn.."
    # end

  end
end

@game = TicTacToe::GameBoard.new
