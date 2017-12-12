local inspect = require 'inspect'
local Board = require 'board'
local Computer = require 'computer_player'

board = Board:new()
GRID = {}
EMPTY_SQUARE = " "
GRID[1] = {"| ___ |", " ___ |", " ___ |"}
GRID[2] = {"| ___ |", " ___ |", " ___ |"}
GRID[3] = {"| ___ |", " ___ |", " ___ |"}
x_mark = "  x  |"
o_mark = "  o  |"

-- gameplay section
function determine_player_type(p1, p2)

  if p1 == "h" then
    PLAYER_1 = {type="human", symbol="x"}
  else
    PLAYER_1 = Computer:new("x", "computer")
  end

  if p2 == "h" then
    PLAYER_2 = {type="human", symbol="o"}
  else
    PLAYER_2 = Computer:new("o", "computer")
  end
  current_player = PLAYER_1
end

function get_players()
  io.write("Let's decide who is playing.\n Enter 'h' for human and 'c' for computer\n What would you like Player 1 to be?\n")
  local p1 = io.read()
  if (p1 ~= "h") and (p1 ~= "c") then
    io.write("I'm sorry, that input is invalid, let's try agian.\n")
    return false
  end
  io.write("Ok, what would you like Player 2 to be?\n")
  local p2 = io.read()
  if (p2 ~= "h") and (p2 ~= "c") then
    io.write("I'm sorry, that input is invalid, let's try agian.\n")
    return false
  end

  determine_player_type(p1, p2)

  return true
end

function greet()
  os.execute("clear")
  io.write("Welcome to tic-tac-toe! \n")
  io.write("Player 1 is x, Player 2 is o.\n Player 1 plays first.\n")
  local got_players = false
  while got_players == false do
    got_players = get_players()
  end

end


function play_turn()
  local moved = false
  local x, y

  while (moved == false) do
    if current_player.type == "human" then
      x, y = get_user_input()
    else
      local move = current_player:get_computer_input(board:dup())
      x, y = move[1], move[2]
    end
    if board:valid_move(x, y) then
      board:move_piece(x, y, current_player.symbol)
      x, y = nil, nil
      moved = true
    end
  end

end

function get_user_input()
  local valid = false
  while valid == false do
    os.execute("clear")
    render(board.grid)
    io.write("Player ", current_player.symbol, " ,please enter the row where you want to play.\n")
    x = io.read()
    io.write("Please enter the column where you want to play.\n")
    y = io.read()
    if parse(x, y) then
      x, y = parse(x, y)
      valid = true
    end
  end
  return x, y
end

function play_game()
  greet()
  os.execute("clear")
  render(board.grid)
  local OVER = false
  while (OVER == false) do
    play_turn()
    render(board.grid)
    if Board:won(board) then
      os.execute("clear")
      render(board.grid)
      io.write(current_player.symbol, " wins!!!\n")
      OVER = true
    elseif Board:draw(board) then
      os.execute("clear")
      render(board.grid)
      io.write("It's a Draw!\n")
      OVER = true
    end
    swap()
  end
end
-- end gameplay section

-- util section
function render(a_board)
  io.write("    1     2     3     \n")
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


function swap()
  if current_player == PLAYER_1 then
    current_player = PLAYER_2
  else
    current_player = PLAYER_1
  end
end


function parse(x, y)
  if string.len(x) == 1 and string.len(y) == 1  and (type(tonumber(x)) == "number" and type(tonumber(y)) == "number") then
    x = tonumber(x)
    y = tonumber(y)
    return x, y
  end
  return false
end

play_game()
