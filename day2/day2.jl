using DelimitedFiles

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

function day2_safety(input_path::AbstractString)
  data = read_data(input_path)
  res = 0
  for i in axes(data,1)
    drow = diff(data[i])
    if all(drow .<= 0) || all(drow .>= 0) & (all(abs.(drow) .>= 1 .&& abs.(drow) .<= 3))
      if all(abs.(drow) .>= 1 .&& abs.(drow) .<= 3)
        res += 1
      end
    end  
  end
  return res
end


day2_safety(joinpath(@__DIR__,"ressources/day2_test.txt"))
day2_safety(joinpath(@__DIR__,"ressources/day2_input.txt"))
