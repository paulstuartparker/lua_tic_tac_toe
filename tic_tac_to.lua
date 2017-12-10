local inspect = require 'inspect'


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
local board = {}
board[1] = {" ", " ", " "}
board[2] = {" ", " ", " "}
board[3] = {" ", " ", " "}
OVER = false


-- gameplay section
function get_players()
  io.write("Let's decide who is playing.\n Enter 'h' for human and 'c' for computer\n What would you like Player 1 to be?\n")
  p1 = io.read()
  if (p1 ~= "h") and (p1 ~= "c") then
    io.write("I'm sorry, that input is invalid, let's try agian.\n")
    return false
  end
  io.write("Ok, what would you like Player 2 to be?")
  p2 = io.read()
  if (p2 ~= "h") and (p2 ~= "c") then
    io.write("I'm sorry, that input is invalid, let's try agian.\n")
    return false
  end

  if (p1 == "h") then
    PLAYER_1.type = "human"
  else
    PLAYER_1.type = "computer"
  end

  if (p2 == "h") then
    PLAYER_2.type = "human"
  else
    PLAYER_2.type = "computer"
  end

  return true

end

function greet()
  os.execute("clear")
  io.write("Welcome to tic-tac-toe! \n")
  io.write("Player 1 is x, Player 2 is o.\n Player 1 plays first.\n")
  got_players = false
  while got_players == false do
    got_players = get_players()
  end

end


function play_turn()
  moved = false
  while (moved == false) do

    if current_player.type == "human" then
      x, y = get_user_input()
    else
      local move = get_computer_input()
      x, y = move[1], move[2]
    end
    if valid_move(x, y) then
      move_piece(x, y, board)
      x, y = nil, nil
      moved = true
    end

    if won(board) then
      io.write(current_player.symbol, " wins!!!\n")
      OVER = true
    elseif draw(board) then
      io.write("It's a Draw!\n")
      OVER = true
    else
      swap()
    end

  end
end

function get_user_input()
  valid = false
  while valid == false do
    os.execute("clear")
    render(board)
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
  render(board)
  while (OVER == false) do
    play_turn()
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

function move_piece(x, y, this_board, current)
  board[x][y] = current_player.symbol
end

function fake_move(x, y, this_board, current)
  this_board[x][y]= current
end


function swap()
  if current_player == PLAYER_1 then
    current_player = PLAYER_2
  else
    current_player = PLAYER_1
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

function deep_dup(_board)
  if type(_board) ~= 'table' then return _board end
  local res = {}
  for k, v in pairs(_board) do res[deep_dup(k)] = deep_dup(v) end
  return res
end
--
-- local function deep_dup(original)
--     local copy = {}
--     for k, v in pairs(original) do
--         -- as before, but if we find a table, make sure we copy that too
--         if type(v) == 'table' then
--             v = deep_dup(v)
--         end
--         copy[k] = v
--     end
--     return copy
-- end

-- function deep_dup(orig)
--     local orig_type = type(orig)
--     local copy
--     if orig_type == 'table' then
--         copy = {}
--         for orig_key, orig_value in next, orig, nil do
--             copy[deep_dup(orig_key)] = deep_dup(orig_value)
--         end
--         setmetatable(copy, deep_dup(getmetatable(orig)))
--     else -- number, string, boolean, etc
--         copy = orig
--     end
--
--     return copy
-- end

-- end util

-- win / draw / loss evaluation

function valid_move(x, y)
  if (x < 4 and x > 0) and (y < 4 and y > 0) then
    if board[x][y] ~= " " then
      return false
    end
    return true
  end
  return false
end

function check_hor(this_board)
  how_win = false
  for j = 1, 3, 1 do
    if (this_board[j][1] == this_board[j][2]) and (this_board[j][1] == this_board[j][3]) and (this_board[j][1] ~= " ") then
      hor_win = true
    end
  end
  return hor_win
end

function check_vert(this_board)
  vert_win = false
  for z = 1, 3, 1 do
    if (this_board[1][z] == this_board[2][z]) and (this_board[1][z] == this_board[3][z]) and (this_board[1][z] ~= " ") then
      vert_win = true
    end
  end
  return vert_win
end

function check_diag(this_board)
  diag_win = false
  if (this_board[1][1] == this_board[2][2]) and (this_board[1][1] == this_board[3][3]) and (this_board[1][1] ~= " ") then
    diag_win = true
  elseif (this_board[1][3] == this_board[2][2]) and (this_board[1][3] == this_board[3][1]) and (this_board[1][3] ~= " ") then
    diag_win = true
  end
return diag_win
end


function won(this_board)
  if check_hor(this_board) or check_vert(this_board) or check_diag(this_board) then
    return current_player
  end
  return false
end

function draw(this_board)
  all_filled = true
  for i = 1, 3, 1 do
    for j = 1, 3, 1 do
      if this_board[i][j] == " " then
        all_filled = false
      end
    end
  end

  return all_filled
end

-- end win eval section

-- computer player section

function get_computer_input()
  _board = deep_dup(board)
  local moves = find_open_moves(_board)
  local is_max = true
  local best_move = nil
  local best_value = -1000
  local future_val = -1000
  local symbol = nil
  if current_player.symbol == "x" then
    symbol = "o"
  else
    symbol = "x"
  end
  for k, v in pairs(moves) do
    local future = deep_dup(_board)
    fake_move(v[1], v[2], future, current_player.symbol)
    future_val = search_tree_for_move(future, not is_max, symbol)
    if (future_val > best_value) then
      best_value = future_val
      best_move = {v[1], v[2]}
    end
  end
  print(inspect(best_move))
  return best_move
end

function search_tree_for_move(future, is_max, _symbol)

  if over(future) then
    print(inspect(future))
    print("+++---------------------++++")
    print(inspect(board))
    print(evaluate_board(future, is_max))
    return evaluate_board(future, is_max)
  end

  local this_symbol = nil
  local best_val = nil
  local this_future_val = nil

  if _symbol == "x" then
    this_symbol = "o"
  else
    this_symbol = "x"
  end

  local this_moves = find_open_moves(future)
  if is_max then
    best_val = -1000
    this_future_val = -1000
    for k, v in pairs(this_moves) do
      local this_future = deep_dup(future)
      fake_move(v[1], v[2], this_future, this_symbol)
      this_future_val = search_tree_for_move(this_future, not is_max, this_symbol)
      if (this_future_val > best_val) then
        best_val = this_future_val
      end
    end
  else
    best_val = 1000
    this_future_val = 1000
    for k, v in pairs(this_moves) do
      local this_future = deep_dup(future)
      move_piece(v[1], v[2], this_future, this_symbol)
      this_future_val = search_tree_for_move(this_future, not is_max, symbol)
      if (this_future_val < best_val) then
        best_val = this_future_val
      end
    end
  end

  return this_future_val
end

function over(_board)
  if won(_board) or draw(_board) then
    return true
  else
    return false
  end
end

function evaluate_board(future, is_max)
  if draw(future) then
    return 0
  elseif is_max then
    return -10
  else
    return 10
  end
end



function find_open_moves(future_board)
  local moves = {}
  for i = 1, 3, 1 do
    for j = 1, 3, 1 do
      if future_board[i][j] == " " then
        table.insert(moves, {i , j})
      end
    end
  end
  return moves
end


play_game()
