module TicTacToe
  ##
  # GameStatus module, included in the GameBoard to provide game status stuff
  module GameStatus
    STATUSES = [:win, :block]

    ##
    # Messages
    BLOCK_MESSAGE = "GameOver, BLOCK!"
    WIN_MESSAGE   = lambda { |player| "GameOver, #{player.name} WIN!" }

    def self.included(klass)
      attr_reader :status

      klass.instance_variable_set(:@status, nil)

      # GameBoard possible win cells commbined
      klass.const_set(:POSSIBLE_WIN_CELLS,
        [
          [1, 2, 3], [1, 4, 7], [1, 5, 9],
          [2, 5, 8],
          [3, 5, 7], [3, 6, 9],
          [4, 5, 6],
          [7, 8, 9]
        ]
      )
    end


    # Check for current_player has won?
    #
    # [Returns]
    # A Boolean representing whether the GameBoard#current_player won the game
    def win?
      GameBoard::POSSIBLE_WIN_CELLS.each do |possible_win|
        if possible_win.map{|p| p - 1}.all? {|cell| board[cell] == @current_player.tic_symbol}
          return true
        end
      end

      false
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
