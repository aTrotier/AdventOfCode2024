using DelimitedFiles

function day1_distance(input_path::AbstractString)
  input = Int.(readdlm(input_path))
  l1 = sort(input[:,1])
  l2 = sort(input[:,2])
  return sum(abs.(l1.-l2))
end

day1_distance("ressources/day1_test.txt")
day1_distance("ressources/day1_input.txt")

####
function day1_similarity(input_path::AbstractString)
  input = Int.(readdlm(input_path))
  d=Dict{Int,Int}()
  res = 0
  for i in axes(input,1)
    keyval = input[i,1]
    if ~haskey(d,input[i])
      d[keyval] = keyval*sum(input[:,2].==keyval)
    end
    res = res + d[keyval]
  end

  return res
end

day1_similarity("ressources/day1_test.txt")
day1_similarity("ressources/day1_input.txt")