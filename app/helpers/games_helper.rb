module GamesHelper

  def play_or_watch game
    game['players'].include?(nil) ? 'Play' : 'Watch'
  end

  def player_turn
    "#{@game['current_player'] == current_user ? 'Your' : @game['current_player']}"
  end

end
