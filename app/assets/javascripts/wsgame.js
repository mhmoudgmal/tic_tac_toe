// Messages need to be handled when player attempting to play (make a change on board) -->

//boardchange
//playerchange
//error ->
//	1 - attempting to play while the turn is not mine
// 	2 - attempting to play over non-empty cell
//won
//lost

SymIcon = function (sym) {
	var imgdiv = "<div class='Absolute-Center'"+
						"align='center'><img class='avatar' src='/assets/{{sym}}' /></div>";

	return Mustache.render(imgdiv, { sym: sym.toLowerCase() });
}

TicTacToeSocket = function(player, game_id) {
	this.player = player;
	this.game_id = game_id;

	this.socket = new WebSocket(Game.websocket_url + "games/" + game_id)

	this.initBinds();
};
//
TicTacToeSocket.prototype.initBinds = function() {

	var _this = this;

	$('.cell').on('click', function() {
			_this.updateBoard(this.id.split('-')[1])
	});

	this.socket.onopen = function(){
		console.log("Hello from Player");
	};

	this.socket.onmessage = function(evt) {

		var tokens = evt.data.split(" ");

		// handle messages when websocket envloved
		// get the command - conventionally: the first text in the space splitted text
		switch(tokens[0]) {
			case "playerchange":
				_this.playerchange(tokens.slice(1).join(" "));
				break;
			case "boardchange":
				_this.boardchange(tokens.slice(1));
				break;
			case "err":
				_this.err(tokens.slice(1).join(" "));
				break;
			case "gameover":
				_this.gameover(tokens.slice(1).join(" "));
				break;
		}
		console.log(evt.data);
	};
};

//
TicTacToeSocket.prototype.updateBoard = function(value) {
	var template = "update {{game_id}} {{player}} {{position}}";
	this.socket.send(Mustache.render(template, {
		player: this.player,
		game_id: this.game_id,
		position: value
	}));
};

//
TicTacToeSocket.prototype.playerchange = function(msg) {
	console.log(this);
	$("#current-player-notifier #dynoti").html("")
	$("#current-player-notifier u").html(msg);
};

//
TicTacToeSocket.prototype.boardchange = function(msg) {
	var position = "#cell-" + parseInt(msg[msg.length-1]);
	$(position).html(SymIcon(msg[0]));
};

//
TicTacToeSocket.prototype.err = function(msg) {
	console.log(this);
	$("#current-player-notifier #dynoti").html(msg);
};

TicTacToeSocket.prototype.gameover = function(msg) {
	console.log(this);
	$("#current-player-notifier").html(msg);
};
