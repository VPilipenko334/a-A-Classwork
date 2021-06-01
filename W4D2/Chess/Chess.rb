require_relative "Player"
require_relative "Display"
require_relative "Board"

class Game
    def initialize(player_1, player_2)
        @board = Board.new 
        @display = Display.new
        @player_1 = player_1
        @player_2 = player_2
        @current_player = @player_1
    end

    # board gets displayed showing all the pieces 
    # ask first player for move 
    # new board is displayed because piece got moved 
    # switches turns 
    # repeat for next player 
    def play
  
    end

    def notify_players
        
    end

    def swap_turn!

    end


end 