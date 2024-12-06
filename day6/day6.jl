path_ = joinpath(@__DIR__,"ressources/input.txt")
l = readlines(path_)
map = reduce(vcat, permutedims.(collect.(l)))

###
function move_guard(map)
  char_list = ['^', '>', '<','v']
  char_move = Dict('^' => CartesianIndex(-1,0), '>' => CartesianIndex(0,1), '<' => CartesianIndex(0,-1),'v' => CartesianIndex(1,0))
  char_next = Dict('^' => '>', '>' => 'v','v' => '<','<' => '^')
 
  start_idx=[]
  for c in char_list
    tmp = findall(map.==c)
    if ~isempty(tmp)
      start_idx = tmp[1]
    end
  end

  if isempty(start_idx.I)
    return map,false
  end

  # move guard by 1
  new_pos = start_idx .+ char_move[map[start_idx]]
  guard_on_map = true
  if all(new_pos.I .> 0) && all(new_pos.I .<= size(map))  # check out of bounds
    if map[new_pos] == '.' ||  map[new_pos] == 'X'
      map[new_pos] = map[start_idx]
      map[start_idx] = 'X'
    elseif map[new_pos] == '#'
      map[start_idx] = char_next[map[start_idx]]
    end
  else
    map[start_idx] = 'X'
    guard_on_map = false
  end
  return map,guard_on_map
end

guard_on_map = true
while guard_on_map
  map,guard_on_map = move_guard(map)
end
res = findall(map .== 'X')
