require_relative './game_status'
require_relative './player'
require_relative './helper'
require 'byebug'
require 'ostruct'

module TicTacToe
  class GameBoard

    attr_reader :board, :players, :current_player

    include TicTacToe::GameStatus
    include TicTacToe::Helper

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

      raise 'Not your turn' unless player_turn_check(player)
      raise 'Not blank' if board[position-1] != false

      board[position-1] = player_sym player

      eval(check_game_status)

      change_player
    end



    # Changes player after #update_board
    # Returns::
    #   current_player after has been changed from first player to second player and vice versa
    def change_player
      @current_player =
        players.reject { |p| p.object_id == @current_player.object_id }.first

      OpenStruct.new({message: "#{@current_player.name} turn", status: :playerchange})
    end



    def check_game_status
      if win?
        return 'return OpenStruct.new({message:  "GameOver, #{@current_player.name} WIN!", status: :gameover})'
      elsif finished?
        return 'return OpenStruct.new({message: "GameOver, BLOCK!", status: :gameover})'
      end

      ''
    end

  end
end

# @game = TicTacToe::GameBoard.new
