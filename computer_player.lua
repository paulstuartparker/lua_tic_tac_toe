local Board = require 'board'
local inspect = require 'inspect'

Computer = {}

function Computer:new(symbol)
  computer = {symbol=symbol}
  setmetatable(computer, self)
  self.__index = self
  return computer
end

function Computer:get_computer_input(board)
  _board = board:dup()
  local moves = self:find_open_moves(_board)

  depth = 0
  local is_max = true
  local best_value = -1000
  local future_val, best_move, future
  local symbol = self.symbol
  for k, v in pairs(moves) do
    future = _board:dup()
    future:move_piece(v[1], v[2], symbol)
    future_val = Computer:search_tree_for_move(future, not is_max, symbol, depth + 1)

    if (future_val > best_value) then
      best_value = future_val
      best_move = {v[1], v[2]}
    end
  end

  return best_move
end

function Computer:change_symbol(symbol)
  if symbol == "x" then
    return "o"
  else
    return "x"
  end
end

function Computer:search_tree_for_move(future, is_max, _symbol, depth)

  local symbol = Computer:change_symbol(_symbol)

  if Computer:over(future) == true then
    return Computer:evaluate_board(future, is_max, depth)
  end

  local future_val, best_val
  local moves = Computer:find_open_moves(future)

  if is_max then
    best_val = -1000
    for k, v in pairs(moves) do
      local this_future = future:dup()
      this_future:move_piece(v[1], v[2], symbol)
      future_val = self:search_tree_for_move(this_future, not is_max, symbol, depth + 1)
      if (future_val > best_val) then
        best_val = future_val
      end
    end
    return best_val
  else
    best_val = 1000
    for k, v in pairs(moves) do
      local this_future = future:dup()
      this_future:move_piece(v[1], v[2], symbol)
      future_val = self:search_tree_for_move(this_future, not is_max, symbol, depth + 1)
      if (future_val < best_val) then
        best_val = future_val
      end
    end
    return best_val
  end

end

function Computer:over(board)
  if Board:won(board) == true or Board:draw(board) == true then
    return true
  else
    return false
  end
end

function Computer:evaluate_board(future, is_max, depth)
  if Board:draw(future) then
    return 0
  elseif is_max then
    return -100
  else
    return 100
  end
end


function Computer:find_open_moves(future_board)
  local moves = {}
  for i = 1, 3, 1 do
    for j = 1, 3, 1 do
      if future_board.grid[i][j] == " " then
        table.insert(moves, {i , j})
      end
    end
  end
  return moves
end

return Computer
