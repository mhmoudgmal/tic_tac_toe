class GameSocket
	def initialize app
		@app = app
		@players = []
	end

	def call env
		@env = env

		if socket_request?
			socket = spawn_socket
			socket.rack_response
		else
			@app.call env
		end
	end

	private
	attr_reader :env

	def socket_request?
		Faye::WebSocket.websocket? env
	end

	def spawn_socket
		socket = Faye::WebSocket.new env
		@players << socket

		puts @players

		socket.on :open do
			socket.send "Hello from GameBoard"
		end

		socket.on :message do |event|
			begin
				tokens = event.data.split " "
				operation = tokens.delete_at 0

				case operation
				when "update"
					updateBoard socket, tokens
				end

			rescue Exception => e
				p e
				p e.backtrace
			end

			socket.send(event.data)
		end

		socket.on :close do |event|
			puts "connection closed"
		end

		def updateBoard socket, tokens
			service = TicTacToe::UpdateBoardService.new({
				game_id: tokens[0],
				player: tokens[1],
				position: tokens[2]
			})

			result = service.execute

			if result.action
				msg = "boardchange " + result.action
				notify_oponent socket, msg
			end

			case result.status
			when :gameover
				msg = "gameover " + result.message
				notify_oponent socket, msg
			when :playerchange
				msg = "playerchange " + result.message
				socket.send(msg)
				notify_oponent socket, msg
			when :err
				msg = "err " + result.message
				socket.send(msg)
			end
		end


		def notify_oponent socket, message
			@players.reject do |player|
				!same_game?(socket, player)
			end.each do |player|
				player.send message
			end
		end

		def same_game? sock1, sock2
			sock1.env["REQUEST_PATH"] == sock2.env["REQUEST_PATH"]
		end

		socket
	end
end
