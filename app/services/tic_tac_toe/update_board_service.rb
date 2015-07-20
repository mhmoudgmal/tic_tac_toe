require 'tic_tac_toe'
require 'ostruct'

module TicTacToe
  class UpdateBoardService

    attr_reader :game_id, :player, :position

    def initialize options
      @player   = options[:player]
      @game_id  = options[:game_id]
      @position = options[:position]
    end

    def execute
      game = loadGame
      updated = game.update_board player, position.to_i

      $redis.set("game##{game_id}", game.to_hash)

      updated.action = "#{game.board[position.to_i - 1]} at #{position.to_i}"

      updated
    rescue Exception => e
      return OpenStruct.new({message: e.message, status: :err})
    end


    private

    def loadGame
      game_hash = eval($redis.get("game##{game_id}"))
      TicTacToe::GameBoard.new.from_hash game_hash
    end
  end
end
