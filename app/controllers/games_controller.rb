class GamesController < ApplicationController
  include ApplicationHelper


  layout nil
  before_filter :check_for_player, except: [:login, :landing]

  def landing
    if session[:player]
      redirect_to games_path
    end
  end

  def index
    # get all game ids from redis to display it
    all_games_ids = $redis.keys 'game#*'

    # FIXME: enhance to O(1) call instead of iter over the ids and fetch O(n) stmt
    # Hint: search for redis command
    @games = all_games_ids.map do |game|
      id = game.split('#').second
      game_hash = eval($redis.get(game))
      game_hash['id'] = id
      game_hash
    end
  end

  # FIXME: extract service
  def login
    # getting all players
    players = $redis.lrange('players', 0, -1)

    if players.include?(game_params["name"])
      @err = 'choose another name, this one already exist'
      respond_to { |format| format.js }
    else
      # add the player to redis
      player = game_params["name"]
      $redis.rpush('players', player)

      # FIXME: this is the soo simple and stupid way to handle players in the game,
      # we can store sessions in redis and map via sessionid
      session[:player] = player

      respond_to do |format|
        format.js {
          render :js => "window.location.href='" + games_path+ "'"
        }
      end
    end
  end

  def new_game
    @game = TicTacToe::TicTacToeService.new(session[:player]).play
    $redis.set("game##{@game.object_id}", @game.to_hash)

    redirect_to game_path(id: @game.object_id)
  end

  def show
    loadGame
    data_bundle
  rescue
    redirect_to games_path
  end


  def update
  end

  def join
    loadGame
    @game['players'][1] = session[:player]

    $redis.set("game##{params[:id]}", @game)

    redirect_to game_path(id: params[:id])
  end

  private

  def loadGame
    @game = eval($redis.get("game##{params[:id]}"))
  end

  def game_params
    params.require(:players).permit(:name)
  end

  def check_for_player
    if session[:player].nil?
      redirect_to root_url
    end
  end

  def data_bundle
    gon.game = @game
    gon.game_id = params[:id]
    gon.current_user = current_user
  end
end
