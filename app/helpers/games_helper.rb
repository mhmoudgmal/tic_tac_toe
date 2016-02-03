module GamesHelper
  def play_or_watch game
    if game['players'].include?(nil)
      'Play'
    elsif game['players'].include?(current_user)
      'Continue'
    else
      'Watch'
    end
  end

  def player_turn
    "#{@game['current_player'] == current_user ? 'Your' : @game['current_player']}"
  end
end
