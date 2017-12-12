
Board = {}

function Board:new(board)
  board = board or { grid = {{" ", " ", " "}, {" ", " ", " "}, {" ", " ", " "}}}
  setmetatable(board, self)
  self.__index = self
  return board
end

function Board:flatten()
  local flat = {}
  for k, v in pairs(self.grid) do
    for x, y in pairs(v) do
      table.insert(flat, y)
    end
  end
return flat
end


function Board:move_piece(x, y, current)
  self.grid[x][y] = current
end

function Board:dup()

  new_board = self:new()
  for k, v in pairs(self.grid) do
    local i = 1
    for x, y in pairs(v) do
      new_board.grid[k][i] = y
      i = i + 1
    end
  end
  return new_board
end



function Board:valid_move(x, y)
  if (x < 4 and x > 0) and (y < 4 and y > 0) then
    if self.grid[x][y] ~= " " then
      return false
    end
    return true
  end
  return false
end



function Board:check_hor()
  local hor_win = false
  for j = 1, 3, 1 do
    if (self.grid[j][1] == self.grid[j][2]) and (self.grid[j][1] == self.grid[j][3]) and (self.grid[j][1] ~= " ") then
      hor_win = true
    end
  end
  return hor_win
end

function Board:check_vert()
  local vert_win = false
  for z = 1, 3, 1 do
    if (self.grid[1][z] == self.grid[2][z]) and (self.grid[1][z] == self.grid[3][z]) and (self.grid[1][z] ~= " ") then
      vert_win = true
    end
    if (self.grid[1][3] == self.grid[2][3]) and (self.grid[3][3] == self.grid[1][3]) and (self.grid[1][3] ~= " ") then
      vert_win = true
    end
  end

  return vert_win
end

function Board:check_diag()
  local diag_win = false
  if (self.grid[1][1] == self.grid[2][2]) and (self.grid[1][1] == self.grid[3][3]) and (self.grid[1][1] ~= " ") then
    diag_win = true
  elseif (self.grid[1][3] == self.grid[2][2]) and (self.grid[1][3] == self.grid[3][1]) and (self.grid[1][3] ~= " ") then
    diag_win = true
  end
return diag_win
end


function Board:won(board)
  if board:check_hor() == true or board:check_vert() == true or board:check_diag() == true then
    return true
  end
  return false
end

function Board:draw(board)
  if Board:won(board) then
    return false
  end
  all_filled = true
  flat = board:flatten()
  for i = 1, 9, 1 do
    if flat[i] == " " then
      all_filled = false
    end

  end
  return all_filled
end

return Board
