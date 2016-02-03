module TicTacToe
  module Helper
    def to_hash
      {}.tap do |game|
        game["board"]          = board
        game["players"]        = players.map(&:name)
        game["current_player"] = current_player.name
      end.to_json
    end

    def from_hash(hash)
      @board = hash['board']
      @players.first.name = hash['players'][0]
      @players.second.name = hash['players'][1]

      @current_player = @players.select { |p|
        p.name == hash['current_player']
      }.first

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
