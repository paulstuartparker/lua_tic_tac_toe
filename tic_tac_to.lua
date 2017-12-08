PLAYER_1 = {type="human", symbol="x"}
PLAYER_2 = {type="human", symbol="o"}
current_player = PLAYER_1
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
  io.write("Welcome to tic-tac-toe! \nTo move, enter the row you would like to move to followed by a comma then space, then the column you would like to move to. \ne.g: 1, 2 \n")
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

function move_piece(x, y)
  print "moving"
  board[x][y] = current_player.symbol
  print(board[x][y])
end

function valid_move(x, y)
  if (x < 4 and x > 0) and (y < 4 and y > 0) then
    if board[x][y] ~= " " then
      return false
    end
    return true
  end
  return false
end


function swap()
  if current_player == PLAYER_1 then
    current_player = PLAYER_2
  else
    current_player = PLAYER_1
  end
end

function play_turn()
  moved = false
  while (moved == false) do
    if current_player.type == "human" then
      x, y = get_user_input()
    else
      x, y = get_computer_input()
    end
    if valid_move(x, y) then
      move_piece(x, y)
      x, y = nil, nil
      moved = true
      swap()
    end
  end
end


function parse(x, y)
  if string.len(x) == 1 and string.len(y) == 1 then

    x = tonumber(x)
    y = tonumber(y)
    return x, y
  end
  return false
end

function won()
  return false
end

function get_user_input()
  valid = false
  while valid == false do
    os.execute("clear")
    render(board)
    io.write("Please enter the row where you want to play.\n")
    x = io.read()
    io.write("Please enter the column where you want to play.\n")
    y = io.read()
    if parse(x, y) then
      x, y = parse(x, y)
      print(valid)
      valid = true
      -- print(valid)
      -- print(current_player.symbol)
    end
  end
  return x, y
end

function play_game()
  greet()
  render(board)
  while (won() == false) do
    play_turn()
  end
  io.write(current_player, "wins!!!\n")
end

-- render(board)
play_game()
