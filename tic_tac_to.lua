print("hellow world")

PLAYER_1 = "x"
PLAYER_2 = "o"
EMPTY_SQUARE = " "
GRID = {}
GRID[1] = {"| ___ |", " ___ |", " ___ |"}
GRID[2] = {"| ___ |", " ___ |", " ___ |"}
GRID[3] = {"| ___ |", " ___ |", " ___ |"}
x_mark = "  x  |"
o_mark = "  o  |"
board = {}
board[1] = {" ", " ", " "}
board[2] = {" ", " ", " "}
board[3] = {" ", " ", " "}

function greet()
  io.write("Welcome to tic-tac-toe! To move, enter the row you would like to move to \nfollowed by a comma then space, then the column you would like to move to. \ne.g: 1, 2 \n")
end

function render(a_board)

  io.write("    1     2     3     ")
  print("")
  for i = 1, 3, 1 do
    for j = 1, 3, 1 do

      if j == 1 then
        io.write(" |")
      end

      if a_board[i][j] == "x" then
        io.write(x_mark)
      elseif a_board[i][j] == "o" then
        io.write(o_mark)
      else
        io.write("     |")
      end

    end
    print("")

    for j = 1, 3, 1 do
      if j == 1 then
        io.write(i)
      end
      io.write(GRID[i][j])
    end
    print("")
  end
end

function play_turn()
  x, y = get_user_input()
end


function get_user_input()

end


function play_game()
  greet()
  render(board)
end

-- render(board)
play_game()
