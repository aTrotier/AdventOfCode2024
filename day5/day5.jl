path_ = joinpath(@__DIR__,"ressources/input.txt")
l = readlines(path_)

# split file
split_line = findall(isempty.(l))[1]
l_rules = l[1:split_line - 1]
l_update = l[split_line + 1:end]

# split and rules update
upd = split.(l_update,",")
upd = [parse.(Int,upd[i]) for i in eachindex(upd)]

rul = split.(l_rules,"|")
rul = [parse.(Int,rul[i]) for i in eachindex(rul)]

## check update and push to vec

function check_rules(upd,rul)
  bool_res = true
  for j in eachindex(rul)
    pos1 = findall(rul[j][1].==upd)
    pos2 = findall(rul[j][2].==upd)
    if (pos1 > pos2) && (~isempty(pos1) && ~isempty(pos2))
    println(j)
      bool_res = false
      break
    end
  end
  return bool_res ?  upd : nothing
end

upd_check = check_rules.(upd,Ref(rul)) # Ref -> don't vectorized

function count_middle(upd)
  res = 0
  for i in upd
    if ~isnothing(i)
      res += i[ceil(Int,length(i)/2)]
    end
  end
  return res
end

res = count_middle(upd_check)


## Part 2 reorder incorrect lines
# incorrect ones are nothing
upd_false = upd[isnothing.(upd_check)]

function lt(a,b)
  bool_ = false
  for i in rul
    if i[1] == a && i[2] == b
      bool_ = true
    end
  end

  return bool_
end

sort!.(upd_false,lt=(x,y)->lt(x,y))

count_middle(upd_false)