
function read_data(filename)
  data = Vector{Int}[]
  open(filename, "r") do f
      for line in eachline(f)
          row = parse.(Int, split(line))
          push!(data, row)
      end
  end
  return data
end


input_path=joinpath(@__DIR__,"ressources/day2_test.txt")
#input_path=joinpath(@__DIR__,"ressources/day2_input.txt")
row_in = read_data(input_path)

function day2_safety(row)
  res = 0
  for i in axes(row,1)
    drow = diff(row[i])
    if (all(drow .<= 0) || all(drow .>= 0)) && (all(abs.(drow) .>= 1 .&& abs.(drow) .<= 3))
        res += 1
    end  
  end
  return res
end

day2_safety(row_in)

## second part
function day2_remove_level(row_in)
  res=0
  for i in axes(row_in,1)
    res_test = false
    for j in axes(row_in[i],1)
      tmp = copy(row_in[i])
      deleteat!(tmp,j)
      drow = diff(tmp)
      if (all(drow .<= 0) || all(drow .>= 0)) && (all(abs.(drow) .>= 1 .&& abs.(drow) .<= 3))
        res_test = true
      end  
    end

    if res_test;res+=1 end
  end
  return res
end


#input_path=joinpath(@__DIR__,"ressources/day2_test.txt")
input_path=joinpath(@__DIR__,"ressources/day2_input.txt")
row_in = read_data(input_path)

day2_remove_level(row_in)