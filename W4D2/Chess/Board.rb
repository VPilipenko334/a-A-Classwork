

[ [0, 1, 2, 3, 4, 5, 6, 7],
  [0, 1, 2, 3, 4, 5, 6, 7],
  [0, 1, 2, 3, 4, 5, 6, 7],
  [0, 1, 2, 3, 4, 5, 6, 7],
  [0, 1, 2, 3, 4, 5, 6, 7],
  [0, new_pawn pos, 2, 3, 4, 5, 6, 7],
  [0, Pawn , 2, 3, 4, 5, 6, 7] ]

class Board

  def initialize
    @board = Array.new(8) { Array.new(8) }

  end

  def move_piece(start_pos, end_pos)
    # update board so that whatever piece
    # in the start_pos is now in the end_pos

    

    # raise an exception if there's no piece at start_pos
    # raise exception if piece can't move to end_pos
  end

end
