module TicTacToe
  ##
  # GameStatus module, included in the GameBoard to provide game status stuff
  module GameStatus
    @status = nil

    def self.included(klass)
      attr_reader :status
    end


    # Check for current_player has won?
    #
    # [Returns]
    # A Boolean representing whether the GameBoard#current_player won the game
    def win?
      # FIXME: dynamically check after each player turn
      return false
    end

    # Checks for game over
    #
    # [Returns]
    # A Boolean representing whether all board calls get filled without #win? status raised
    def finished?
      !board.include?(false)
    end

  end
end
