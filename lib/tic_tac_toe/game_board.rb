require_relative './game_status'
require_relative './player'
require_relative './helper'
require 'ostruct'

module TicTacToe
  class GameBoard
    attr_reader :board, :players, :current_player

    include TicTacToe::GameStatus
    include TicTacToe::Helper

    def initialize
      @board    = Array.new(9, false)
      @players  = [
        Player.new('X'),
        Player.new('O')
      ]

      @current_player = @players.first
    end



    ##
    # GameBoard get messaged to update a cell located at +position+ by a +player+.
    #
    # After each update on the board, the board will involve the GameStatus
    # to check whether the +player+ has #win?, or the game has #finshied?
    # without win raised else turn to the next player #change_player.
    def update_board player, position
      raise 'Not your turn' unless player_turn_check(player)
      raise 'Not blank'     unless board[position-1] == false

      board[position-1] = player_sym player

      check_game_status
    end



    # Changes player after #update_board
    #
    # @return current_player [Player]
    #   after it changed from first player to second player and vice versa
    def change_player
      @current_player = players.reject { |p| p == @current_player }.first

      OpenStruct.new(
        {
          message: "#{@current_player.name} turn",
          status: :playerchange
        }
      )
    end



    def check_game_status
      if win?
        return OpenStruct.new(
          {
            message: WIN_MESSAGE.call(@current_player),
            status: :gameover
          }
        )
      elsif finished?
        return OpenStruct.new(
          {
            message: BLOCK_MESSAGE,
            status: :gameover
          }
        )
      else
        change_player
      end
    end

  end
end
