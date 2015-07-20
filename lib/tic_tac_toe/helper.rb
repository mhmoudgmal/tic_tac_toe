module TicTacToe
  module Helper
    def to_hash
      hash = {}
      hash["board"] = board
      hash["players"] = players.map(&:name)
      hash["current_player"] = current_player.name
      hash
    end

    def from_hash hash
      @board = hash['board']
      @players.first.name = hash['players'][0]
      @players.second.name = hash['players'][1]
      @current_player = @players.first.name == hash['current_player'] ?
                        @players.first : @players.second

      self
    end


    def player_sym player
      if player.kind_of?(String)
        players.map(&:name).index(player) == 0 ? 'X' : 'O'
      else
        player.tic_symbol
      end
    end

    def player_turn_check player
      if player.kind_of?(String)
        current_player.name == player
      else
        current_player == player
      end
    end


  end
end
